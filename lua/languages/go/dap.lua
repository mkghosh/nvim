local dap = require("dap")

local metadata = require("languages.go.metadata")

local M = {}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

function M.setup()
    dap.adapters.delve = {

        type = "server",

        port = "${port}",

        executable = {

            command = metadata.tools.dap,

            args = {
                "dap",
                "-l",
                "127.0.0.1:${port}",
            },
        },
    }

    dap.configurations.go = {

        {
            name = "Debug File",

            type = "delve",

            request = "launch",

            program = "${file}",
        },

        {
            name = "Debug Package",

            type = "delve",

            request = "launch",

            program = "${workspaceFolder}",
        },

        {
            name = "Debug Test",

            type = "delve",

            request = "launch",

            mode = "test",

            program = "${file}",
        },
    }
end

return M
