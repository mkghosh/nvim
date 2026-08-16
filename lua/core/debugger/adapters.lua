local dap = require("dap")

local M = {}

--------------------------------------------------------------------------------
-- Python
--------------------------------------------------------------------------------

function M.setup_python()
    local command = vim.fn.stdpath("data")
        .. "/mason/bin/debugpy-adapter"

    if vim.fn.executable(command) ~= 1 then
        vim.notify(
            "debugpy-adapter not found: " .. command,
            vim.log.levels.WARN
        )

        return false
    end

    dap.adapters.python = {
        type = "executable",
        command = command,
        args = {},
    }

    return true
end

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

function M.setup()
    -- Generic DAP setup only.
end

return M
