local uv = vim.uv

local M = {}

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

M.MINIMUM_JDTLS_JAVA = 21

local SEARCH_PATHS = {
    "/usr/lib/jvm",
    "/usr/lib64/jvm",
}

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

---@param path string
---@return boolean
local function is_directory(path)
    local stat = uv.fs_stat(path)

    return stat ~= nil
        and stat.type == "directory"
end

---@param path string
---@return boolean
local function is_jdk(path)
    local java = vim.fs.joinpath(path, "bin", "java")
    local javac = vim.fs.joinpath(path, "bin", "javac")

    return vim.fn.executable(java) == 1
        and vim.fn.executable(javac) == 1
end

---@param path string
---@return string
local function realpath(path)
    return uv.fs_realpath(path) or path
end

---@param path string
---@return integer?
local function version(path)
    local java = vim.fs.joinpath(path, "bin", "java")

    local output = vim.fn.system({
        java,
        "-version",
    })

    local major =
        output:match('version%s+"(%d+)')

    if not major then
        return nil
    end

    return tonumber(major)
end

---@param runtime JavaRuntime
---@return integer?
local function runtime_version(runtime)
    return tonumber(
        runtime.name:match("JavaSE%-(%d+)")
    )
end

--------------------------------------------------------------------------------
-- Discovery
--------------------------------------------------------------------------------

---@return JavaRuntime[]
function M.discover()
    local runtimes = {}
    local seen = {}

    --------------------------------------------------------------------------
    -- JAVA_HOME
    --------------------------------------------------------------------------

    local java_home = vim.env.JAVA_HOME

    if java_home
        and java_home ~= ""
        and is_directory(java_home)
        and is_jdk(java_home)
    then
        local real = realpath(java_home)

        if not seen[real] then
            local major = version(real)

            if major and major >= M.MINIMUM_JDTLS_JAVA then
                table.insert(runtimes, {
                    name = "JavaSE-" .. major,
                    path = real,
                })

                seen[real] = true
            end
        end
    end

    --------------------------------------------------------------------------
    -- Standard JVM directories
    --------------------------------------------------------------------------

    for _, base in ipairs(SEARCH_PATHS) do
        if is_directory(base) then
            for _, entry in ipairs(vim.fn.readdir(base)) do
                local candidate =
                    vim.fs.joinpath(base, entry)

                if is_directory(candidate)
                    and is_jdk(candidate)
                then
                    local real = realpath(candidate)

                    if not seen[real] then
                        local major = version(real)

                        if major
                            and major >= M.MINIMUM_JDTLS_JAVA
                        then
                            table.insert(runtimes, {
                                name = "JavaSE-" .. major,
                                path = real,
                            })

                            seen[real] = true
                        end
                    end
                end
            end
        end
    end

    return runtimes
end

--------------------------------------------------------------------------------
-- Runtime list
--------------------------------------------------------------------------------

---@return JavaRuntime[]
function M.get()
    local runtimes = M.discover()

    table.sort(runtimes, function(a, b)
        local av = runtime_version(a) or 0
        local bv = runtime_version(b) or 0

        if av == bv then
            return a.path < b.path
        end

        return av < bv
    end)

    --------------------------------------------------------------------------
    -- Newest runtime is the default.
    --------------------------------------------------------------------------

    if #runtimes > 0 then
        runtimes[#runtimes].default = true
    end

    return runtimes
end

--------------------------------------------------------------------------------
-- Exact runtime
--------------------------------------------------------------------------------

---@param required integer
---@return JavaRuntime?
function M.exact(required)
    local runtimes = M.get()

    for _, runtime in ipairs(runtimes) do
        if runtime_version(runtime) == required then
            return runtime
        end
    end

    return nil
end

--------------------------------------------------------------------------------
-- Compatible runtime
--------------------------------------------------------------------------------

---@param required integer
---@return JavaRuntime?
function M.compatible(required)
    local runtimes = M.get()

    local best = nil
    local best_version = nil

    for _, runtime in ipairs(runtimes) do
        local major = runtime_version(runtime)

        if major and major >= required then
            if not best_version or major < best_version then
                best = runtime
                best_version = major
            end
        end
    end

    return best
end

--------------------------------------------------------------------------------
-- JDTLS runtime
--------------------------------------------------------------------------------

---@return JavaRuntime?, string?
function M.jdtls()
    local runtimes = M.get()

    if #runtimes == 0 then
        return nil, string.format(
            "JDTLS requires Java >= %d, but no compatible JDK was found.",
            M.MINIMUM_JDTLS_JAVA
        )
    end

    --------------------------------------------------------------------------
    -- Prefer the newest installed compatible JDK.
    --------------------------------------------------------------------------

    local runtime = runtimes[#runtimes]

    return runtime, nil
end

--------------------------------------------------------------------------------
-- Required project runtime
--------------------------------------------------------------------------------

---@param required integer
---@return JavaRuntime?, string?
function M.require(required)
    local runtimes = M.get()

    for _, runtime in ipairs(runtimes) do
        if runtime_version(runtime) == required then
            return runtime, nil
        end
    end

    local installed

    if #runtimes == 0 then
        installed = "none"
    else
        installed = table.concat(
            vim.tbl_map(function(runtime)
                return runtime.name
            end, runtimes),
            ", "
        )
    end

    return nil, string.format(
        "Java %d is required, but Java %d is not installed. Installed JDKs: %s",
        required,
        required,
        installed
    )
end

--------------------------------------------------------------------------------
-- Default
--------------------------------------------------------------------------------

---@return JavaRuntime?
function M.default()
    local runtimes = M.get()

    return runtimes[#runtimes]
end

--------------------------------------------------------------------------------
-- PATH validation
--------------------------------------------------------------------------------

---@return boolean
function M.validate_jdtls()
    local java = vim.fn.exepath("java")

    if java == "" then
        vim.notify(
            "Java was not found in PATH.",
            vim.log.levels.ERROR
        )

        return false
    end

    local output = vim.fn.system({
        java,
        "-version",
    })

    local major =
        tonumber(output:match('version%s+"(%d+)'))

    if not major then
        vim.notify(
            "Unable to determine the Java version used by PATH.",
            vim.log.levels.ERROR
        )

        return false
    end

    if major < M.MINIMUM_JDTLS_JAVA then
        vim.notify(
            string.format(
                "JDTLS requires Java >= %d, but PATH provides Java %d.",
                M.MINIMUM_JDTLS_JAVA,
                major
            ),
            vim.log.levels.ERROR
        )

        return false
    end

    return true
end

return M
