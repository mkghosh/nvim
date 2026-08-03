local M = {}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

---Format the current buffer.
---
---@param opts? FormatterOptions
function M.format(opts)
    opts = vim.tbl_extend("force", {
        async = true,
        lsp_format = "fallback",
    }, opts or {})

    require("conform").format(opts)
end

return M
