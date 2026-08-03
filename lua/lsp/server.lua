local capabilities = require("lsp.capabilities")

local M = {}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

---@param opts? LspServerOptions
---@return LspServerOptions
function M.create(opts)
    return vim.tbl_deep_extend("force", {

        capabilities = capabilities.get(),

    }, opts or {})
end

return M
