local M = {}

function M.refresh()
    vim.lsp.codelens.refresh()
end

function M.enable()
    vim.lsp.codelens.enable(true)
end

function M.disable()
    vim.lsp.codelens.enable(false)
end

function M.toggle()
    local enabled = vim.lsp.codelens.is_enabled()

    vim.lsp.codelens.enable(not enabled)
end

return M
