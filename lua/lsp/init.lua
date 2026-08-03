local M = {}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

function M.setup()
    require("lsp.registry").register()

    require("lsp.diagnostics").setup()

    require("lsp.inlay_hints").setup()

    require("lsp.registry").enable()
end

return M
