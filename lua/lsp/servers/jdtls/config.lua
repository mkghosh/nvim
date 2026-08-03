local M = {}

function M.build(root)
    return {

        cmd = require("lsp.servers.jdtls.command_line").build(),

        root_dir = root,

        settings = require("lsp.servers.jdtls.settings").build(),

        init_options = {
            bundles = require("lsp.servers.jdtls.bundles").find(),
        },

        capabilities = require("lsp.capabilities").get(),

    }
end

return M
