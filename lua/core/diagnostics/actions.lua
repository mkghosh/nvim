local trouble = require("trouble")

local M = {}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

function M.diagnostics()
    trouble.toggle("diagnostics")
end

function M.references()
    trouble.toggle("lsp_references")
end

function M.quickfix()
    trouble.toggle("quickfix")
end

function M.loclist()
    trouble.toggle("loclist")
end

---@param mode? string
function M.symbols(mode)
    trouble.toggle(mode or "symbols")
end

return M
