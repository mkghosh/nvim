---@diagnostic disable: undefined-field

local dap = require("dap")

local M = {}

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

function M.setup()
    dap.configurations.java = {
        {
            type = "java",
            request = "launch",
            name = "Java: Debug",

            cwd = "${workspaceFolder}",

            justMyCode = false,
        },
    }
end

return M
