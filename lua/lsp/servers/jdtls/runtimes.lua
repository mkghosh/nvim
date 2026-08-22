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

    local major = output:match('version%s+"(%d+)')

    if not major then
        return nil
    end

    return tonumber(major)
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
                local candidate = vim.fs.joinpath(base, entry)

                if is_directory(candidate) and is_jdk(candidate) then
                    local real = realpath(candidate)

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
        local av = tonumber(a.name:match("JavaSE%-(%d+)")) or 0
        local bv = tonumber(b.name:match("JavaSE%-(%d+)")) or 0

        if av == bv then
            return a.path < b.path
        end

        return av < bv
    end)

    --------------------------------------------------------------------------
    -- Newest runtime becomes default.
    --------------------------------------------------------------------------

    if #runtimes > 0 then
        runtimes[#runtimes].default = true
    end

    return runtimes
end

--------------------------------------------------------------------------------
-- Find runtime
--------------------------------------------------------------------------------

---@param required integer
---@return JavaRuntime?
function M.find(required)
    local candidates = {}

    for _, runtime in ipairs(M.get()) do
        local major =
            tonumber(runtime.name:match("JavaSE%-(%d+)"))

        if major and major >= required then
            table.insert(candidates, {
                runtime = runtime,
                version = major,
            })
        end
    end

    --------------------------------------------------------------------------
    -- Prefer the smallest compatible JDK.
    --
    -- Example:
    --
    -- required = 21
    -- available = 21, 25
    --
    -- choose 21 rather than 25.
    --------------------------------------------------------------------------

    table.sort(candidates, function(a, b)
        return a.version < b.version
    end)

    return candidates[1] and candidates[1].runtime or nil
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
-- Required runtime
--------------------------------------------------------------------------------

---@param required integer
---@return JavaRuntime?, string?
function M.require(required)
    local runtime = M.find(required)

    if runtime then
        return runtime, nil
    end

    return nil, string.format(
        "Java %d is required, but no compatible JDK was found. Installed JDKs: %s",
        required,
        #M.get() == 0
        and "none"
        or table.concat(
            vim.tbl_map(function(x)
                return x.name
            end, M.get()),
            ", "
        )
    )
end

--------------------------------------------------------------------------------
-- JDTLS runtime validation
--------------------------------------------------------------------------------

---@return boolean
function M.validate_jdtls()
    local java = vim.fn.exepath("java")

    if java == "" then
        vim.notify(
            "JDTLS requires Java >= "
            .. M.MINIMUM_JDTLS_JAVA
            .. ", but `java` was not found in PATH.",
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
            "Unable to determine the Java version used to launch JDTLS.",
            vim.log.levels.ERROR
        )

        return false
    end

    if major < M.MINIMUM_JDTLS_JAVA then
        vim.notify(
            string.format(
                "JDTLS requires Java >= %d, but PATH provides Java %d: %s",
                M.MINIMUM_JDTLS_JAVA,
                major,
                java
            ),
            vim.log.levels.ERROR
        )

        return false
    end

    return true
end

return M
