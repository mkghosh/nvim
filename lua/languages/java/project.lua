local metadata = require("languages.java.metadata")
local runtimes = require("lsp.servers.jdtls.runtimes")

local M = {}

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

local uv = vim.uv

---@param path string
---@return boolean
local function exists(path)
    local stat = uv.fs_stat(path)

    return stat ~= nil
end

---@param path string
---@return string?
local function read(path)
    local fd = io.open(path, "r")

    if not fd then
        return nil
    end

    local content = fd:read("*a")
    fd:close()

    return content
end

---@param value string?
---@return integer?
local function normalize_java_version(value)
    if not value then
        return nil
    end

    value = vim.trim(value)

    --------------------------------------------------------------------------
    -- Maven property references are resolved separately.
    --------------------------------------------------------------------------

    if value:match("^%${[^}]+}$") then
        return nil
    end

    --------------------------------------------------------------------------
    -- Java 8 style:
    --
    -- 1.8 -> 8
    --------------------------------------------------------------------------

    local old = value:match("^1%.(%d+)$")

    if old then
        return tonumber(old)
    end

    --------------------------------------------------------------------------
    -- Modern Java:
    --
    -- 8
    -- 11
    -- 17
    -- 21
    -- 21.0.1
    -- 21-ea
    --------------------------------------------------------------------------

    local major = value:match("^(%d+)")

    return major and tonumber(major) or nil
end

--------------------------------------------------------------------------------
-- Project root
--------------------------------------------------------------------------------

---@return string?
function M.root()
    return vim.fs.root(0, metadata.root_markers)
end

--------------------------------------------------------------------------------
-- Build system
--------------------------------------------------------------------------------

---@return boolean
function M.is_maven()
    local root = M.root()

    if not root then
        return false
    end

    return exists(
        vim.fs.joinpath(root, "pom.xml")
    )
end

---@return boolean
function M.is_gradle()
    local root = M.root()

    if not root then
        return false
    end

    return exists(
            vim.fs.joinpath(root, "build.gradle")
        )
        or exists(
            vim.fs.joinpath(root, "build.gradle.kts")
        )
end

---@return boolean
function M.is_plain_java()
    local root = M.root()

    if not root then
        return false
    end

    return not M.is_maven()
        and not M.is_gradle()
end

---@return JavaBuildSystem?
function M.system()
    local root = M.root()

    if not root then
        return nil
    end

    if exists(
            vim.fs.joinpath(root, "pom.xml")
        ) then
        return "maven"
    end

    if exists(
            vim.fs.joinpath(root, "build.gradle")
        )
        or exists(
            vim.fs.joinpath(root, "build.gradle.kts")
        )
    then
        return "gradle"
    end

    return nil
end

--------------------------------------------------------------------------------
-- Build executable
--------------------------------------------------------------------------------

---@return string?
function M.executable()
    local root = M.root()

    if not root then
        return nil
    end

    local system = M.system()

    if not system then
        return nil
    end

    local build = metadata.build[system]

    if build.prefer_wrapper then
        local wrapper =
            vim.fs.joinpath(
                root,
                build.wrapper
            )

        if exists(wrapper) then
            return "./" .. build.wrapper
        end
    end

    return build.executable
end

--------------------------------------------------------------------------------
-- Toolchain
--------------------------------------------------------------------------------

---@return JavaToolchain?
function M.toolchain()
    local system = M.system()

    if not system then
        return nil
    end

    local executable = M.executable()

    if not executable then
        return nil
    end

    return {
        system = system,
        executable = executable,
    }
end

--------------------------------------------------------------------------------
-- Maven property extraction
--------------------------------------------------------------------------------

---@param pom string
---@return table<string, string>
local function maven_properties(pom)
    local properties = {}

    --------------------------------------------------------------------------
    -- <properties>...</properties>
    --------------------------------------------------------------------------

    local block =
        pom:match(
            "<properties>(.-)</properties>"
        )

    if not block then
        return properties
    end

    --------------------------------------------------------------------------
    -- Extract simple XML properties.
    --
    -- Example:
    --
    -- <java.version>21</java.version>
    -- <maven.compiler.source>${java.version}</maven.compiler.source>
    --------------------------------------------------------------------------

    for name, value in block:gmatch(
        "<([%w_.%-]+)>%s*([^<]-)%s*</%1>"
    ) do
        properties[name] = vim.trim(value)
    end

    return properties
end

--------------------------------------------------------------------------------
-- Maven property resolution
--------------------------------------------------------------------------------

---@param value string?
---@param properties table<string, string>
---@param resolving? table<string, boolean>
---@param depth? integer
---@return string?
local function resolve_maven_value(
    value,
    properties,
    resolving,
    depth
)
    if not value then
        return nil
    end

    value = vim.trim(value)

    resolving = resolving or {}
    depth = depth or 0

    --------------------------------------------------------------------------
    -- Protect against circular references.
    --------------------------------------------------------------------------

    if depth > 20 then
        return nil
    end

    --------------------------------------------------------------------------
    -- Plain value.
    --------------------------------------------------------------------------

    if not value:find("%${", 1, true) then
        return value
    end

    --------------------------------------------------------------------------
    -- Resolve ${property}.
    --------------------------------------------------------------------------

    local resolved = value:gsub(
        "%${([^}]+)}",
        function(name)
            if resolving[name] then
                return ""
            end

            local replacement = properties[name]

            if not replacement then
                return ""
            end

            resolving[name] = true

            local result =
                resolve_maven_value(
                    replacement,
                    properties,
                    resolving,
                    depth + 1
                )

            resolving[name] = nil

            return result or ""
        end
    )

    if resolved == "" then
        return nil
    end

    return vim.trim(resolved)
end

--------------------------------------------------------------------------------
-- Maven value lookup
--------------------------------------------------------------------------------

---@param pom string
---@param properties table<string, string>
---@param tag string
---@return string?
local function maven_value(
    pom,
    properties,
    tag
)
    local value =
        pom:match(
            "<"
            .. tag
            .. ">%s*([^<]+)%s*</"
            .. tag
            .. ">"
        )

    if not value then
        return nil
    end

    return resolve_maven_value(
        value,
        properties
    )
end

--------------------------------------------------------------------------------
-- Maven Java version
--------------------------------------------------------------------------------

---@param pom string
---@return integer?, string?
local function maven_java_version(pom)
    local properties =
        maven_properties(pom)

    --------------------------------------------------------------------------
    -- java.version
    --------------------------------------------------------------------------

    local value =
        maven_value(
            pom,
            properties,
            "java.version"
        )

    if value then
        local version =
            normalize_java_version(value)

        if version then
            return version,
                "maven.java.version"
        end
    end

    --------------------------------------------------------------------------
    -- maven.compiler.release
    --------------------------------------------------------------------------

    value =
        maven_value(
            pom,
            properties,
            "maven.compiler.release"
        )

    if value then
        local version =
            normalize_java_version(value)

        if version then
            return version,
                "maven.compiler.release"
        end
    end

    --------------------------------------------------------------------------
    -- maven.compiler.source
    --------------------------------------------------------------------------

    value =
        maven_value(
            pom,
            properties,
            "maven.compiler.source"
        )

    if value then
        local version =
            normalize_java_version(value)

        if version then
            return version,
                "maven.compiler.source"
        end
    end

    --------------------------------------------------------------------------
    -- maven.compiler.target
    --------------------------------------------------------------------------

    value =
        maven_value(
            pom,
            properties,
            "maven.compiler.target"
        )

    if value then
        local version =
            normalize_java_version(value)

        if version then
            return version,
                "maven.compiler.target"
        end
    end

    return nil
end

--------------------------------------------------------------------------------
-- Gradle Java version
--------------------------------------------------------------------------------

---@param gradle string
---@return integer?, string?
local function gradle_java_version(gradle)
    --------------------------------------------------------------------------
    -- Gradle Java toolchain
    --
    -- languageVersion = JavaLanguageVersion.of(21)
    --------------------------------------------------------------------------

    local value =
        gradle:match(
            "languageVersion%s*=%s*"
            .. "JavaLanguageVersion%.of%s*"
            .. "%(%s*(%d+)%s*%)"
        )

    if value then
        return tonumber(value),
            "gradle.toolchain"
    end

    --------------------------------------------------------------------------
    -- Kotlin DSL
    --
    -- languageVersion.set(JavaLanguageVersion.of(21))
    --------------------------------------------------------------------------

    value =
        gradle:match(
            "languageVersion%.set%s*"
            .. "%(%s*JavaLanguageVersion%.of%s*"
            .. "%(%s*(%d+)%s*%)"
        )

    if value then
        return tonumber(value),
            "gradle.toolchain"
    end

    --------------------------------------------------------------------------
    -- sourceCompatibility = '21'
    --------------------------------------------------------------------------

    value =
        gradle:match(
            "sourceCompatibility%s*=%s*['\"](%d+)"
        )

    if value then
        return tonumber(value),
            "gradle.sourceCompatibility"
    end

    --------------------------------------------------------------------------
    -- targetCompatibility = '21'
    --------------------------------------------------------------------------

    value =
        gradle:match(
            "targetCompatibility%s*=%s*['\"](%d+)"
        )

    if value then
        return tonumber(value),
            "gradle.targetCompatibility"
    end

    --------------------------------------------------------------------------
    -- JavaVersion.VERSION_21
    --------------------------------------------------------------------------

    value =
        gradle:match(
            "sourceCompatibility%s*=%s*"
            .. "JavaVersion%.VERSION_(%d+)"
        )

    if value then
        return tonumber(value),
            "gradle.sourceCompatibility"
    end

    value =
        gradle:match(
            "targetCompatibility%s*=%s*"
            .. "JavaVersion%.VERSION_(%d+)"
        )

    if value then
        return tonumber(value),
            "gradle.targetCompatibility"
    end

    return nil
end

--------------------------------------------------------------------------------
-- Project Java version
--------------------------------------------------------------------------------

---@return integer?, string?
function M.java_version()
    local root = M.root()

    if not root then
        return nil, nil
    end

    --------------------------------------------------------------------------
    -- Maven
    --------------------------------------------------------------------------

    if M.is_maven() then
        local pom =
            read(
                vim.fs.joinpath(
                    root,
                    "pom.xml"
                )
            )

        if pom then
            local version, source =
                maven_java_version(pom)

            if version then
                return version, source
            end
        end
    end

    --------------------------------------------------------------------------
    -- Gradle
    --------------------------------------------------------------------------

    if M.is_gradle() then
        local gradle =
            read(
                vim.fs.joinpath(
                    root,
                    "build.gradle"
                )
            )
            or read(
                vim.fs.joinpath(
                    root,
                    "build.gradle.kts"
                )
            )

        if gradle then
            local version, source =
                gradle_java_version(gradle)

            if version then
                return version, source
            end
        end
    end

    --------------------------------------------------------------------------
    -- No explicit project Java version.
    --------------------------------------------------------------------------

    return nil, nil
end

--------------------------------------------------------------------------------
-- Java version source
--------------------------------------------------------------------------------

---@return string?
function M.java_version_source()
    local _, source =
        M.java_version()

    return source
end

--------------------------------------------------------------------------------
-- Project Java runtime
--------------------------------------------------------------------------------

---@return JavaRuntime?, string?
function M.java_runtime()
    local required, source =
        M.java_version()

    --------------------------------------------------------------------------
    -- No declared version.
    --------------------------------------------------------------------------

    if not required then
        return nil, nil
    end

    --------------------------------------------------------------------------
    -- Exact project JDK.
    --------------------------------------------------------------------------

    local runtime =
        runtimes.exact(required)

    if runtime then
        return runtime, nil
    end

    --------------------------------------------------------------------------
    -- Missing project JDK.
    --------------------------------------------------------------------------

    local installed_runtimes =
        runtimes.get()

    local installed =
        table.concat(
            vim.tbl_map(
                function(item)
                    return item.name
                end,
                installed_runtimes
            ),
            ", "
        )

    if installed == "" then
        installed = "none"
    end

    return nil, string.format(
        "Project requires Java %d (%s), but Java %d is not installed. Installed JDKs: %s",
        required,
        source or "unknown",
        required,
        installed
    )
end

--------------------------------------------------------------------------------
-- Tasks
--------------------------------------------------------------------------------

---@param task TaskDefinition
---@return TaskDefinition?
function M.task(task)
    local toolchain =
        M.toolchain()

    if not toolchain then
        return nil
    end

    local arguments =
        task[toolchain.system]

    if not arguments then
        return nil
    end

    return {
        title = task.title,
        executable = toolchain.executable,
        system = toolchain.system,

        [toolchain.system] = arguments,
    }
end

return M
