local dap = require("dap")

local M = {}

--------------------------------------------------------------------------------
-- Python
--------------------------------------------------------------------------------

local function setup_python()
    local command = vim.fn.exepath("debugpy-adapter")

    if command == "" then
        vim.notify(
            "debugpy-adapter not found",
            vim.log.levels.WARN
        )

        return
    end

    dap.adapters.python = {
        type = "executable",
        command = command,
        args = {},
    }
end

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

function M.setup()
    setup_python()
end

return M
