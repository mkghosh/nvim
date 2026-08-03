local path = require("utils.path")

local M = {}

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

local function executable(cmd)
    return vim.fn.executable(cmd) == 1
end

local function directory(dir)
    return vim.fn.isdirectory(dir) == 1
end

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

function M.check()
    local checks = {

        {
            name = "Java",
            ok = executable("java"),
        },

        {
            name = "Javac",
            ok = executable("javac"),
        },

        {
            name = "JDTLS",
            ok = executable("jdtls"),
        },

        {
            name = "Java Debug Adapter",
            ok = directory(
                path.mason("packages", "java-debug-adapter")
            ),
        },

        {
            name = "Java Test",
            ok = directory(
                path.mason("packages", "java-test")
            ),
        },

    }

    for _, check in ipairs(checks) do
        vim.notify(

            ("%s %s"):format(
                check.ok and "✓" or "✗",
                check.name
            ),

            check.ok and vim.log.levels.INFO
            or vim.log.levels.ERROR

        )
    end
end

return M
