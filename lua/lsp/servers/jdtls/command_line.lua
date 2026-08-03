local launcher = require("lsp.servers.jdtls.launcher")
local workspace = require("languages.java.workspace")
local jvm = require("lsp.servers.jdtls.jvm")

local M = {}

function M.build()
    local cmd = {
        "java",
    }

    vim.list_extend(cmd, jvm)

    vim.list_extend(cmd, {

        "-jar",
        launcher.jar(),

        "-configuration",
        launcher.config(),

        "-data",
        workspace.project(),

    })

    return cmd
end

return M
