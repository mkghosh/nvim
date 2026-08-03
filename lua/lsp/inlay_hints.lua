local autocmd = require("utils.autocmd")

local M = {}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

function M.setup()
    autocmd.create("LspAttach", {

        group = "UserInlayHints",

        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            if not client then
                return
            end

            if client:supports_method(
                    vim.lsp.protocol.Methods.textDocument_inlayHint
                ) then
                vim.lsp.inlay_hint.enable(true, {
                    bufnr = args.buf,
                })
            end
        end,

        desc = "Enable inlay hints",
    })
end

function M.toggle()
    vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled()
    )
end

return M
