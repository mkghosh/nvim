local M = {}

--------------------------------------------------------------------------------
-- Code Actions
--------------------------------------------------------------------------------

function M.actions()
    vim.lsp.buf.code_action()
end

function M.source_actions()
    vim.lsp.buf.code_action({
        context = {
            only = { "source" },
        },
    })
end

function M.quickfix()
    vim.lsp.buf.code_action()
end

return M
