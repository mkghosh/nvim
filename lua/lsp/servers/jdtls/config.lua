local M = {}

function M.build(root)
    local runtimes =
        require("lsp.servers.jdtls.runtimes")

    local runtime, error_message =
        runtimes.jdtls()

    if not runtime then
        error(
            error_message
            or "Unable to find a compatible JDK for JDTLS."
        )
    end

    return {

        cmd =
            require("lsp.servers.jdtls.command_line")
            .build(runtime),

        root_dir = root,

        settings =
            require("lsp.servers.jdtls.settings")
            .build(),

        init_options = {
            bundles =
                require("lsp.servers.jdtls.bundles")
                .find(),
        },

        capabilities =
            require("lsp.capabilities").get(),

    }
end

return M
