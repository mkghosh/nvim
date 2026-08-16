---@diagnostic disable: undefined-field

local jdtls = require("jdtls")

return {

    ------------------------------------------------------------------------
    -- JDTLS Attach
    ------------------------------------------------------------------------

    {
        event = "LspAttach",

        group = "Jdtls",

        callback = function(args)
            local client = vim.lsp.get_client_by_id(
                args.data.client_id
            )

            if not client or client.name ~= "jdtls" then
                return
            end

            ----------------------------------------------------------------
            -- Inlay Hints
            ----------------------------------------------------------------

            if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true, {
                    bufnr = args.buf,
                })
            end

            ----------------------------------------------------------------
            -- CodeLens
            ----------------------------------------------------------------

            if client:supports_method(
                    vim.lsp.protocol.Methods.textDocument_codeLens
                )
            then
                vim.lsp.codelens.enable(true, {
                    bufnr = args.buf,
                })
            end

            ----------------------------------------------------------------
            -- DAP
            ----------------------------------------------------------------

            require("lsp.servers.jdtls.dap").setup()
        end,

        desc = "Configure JDTLS",
    },

}
