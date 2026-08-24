local M = {}

local enabled = true

--------------------------------------------------------------------------------
-- Enable / Disable
--------------------------------------------------------------------------------

function M.enable()
    enabled = true
    vim.lsp.codelens.enable(true)
end

function M.disable()
    enabled = false
    vim.lsp.codelens.enable(false)
end

--------------------------------------------------------------------------------
-- Toggle
--------------------------------------------------------------------------------

function M.toggle()
    enabled = not enabled
    vim.lsp.codelens.enable(enabled)
end

return M
