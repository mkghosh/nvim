local actions = require("core.diagnostics.actions")

local M = {}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

M.diagnostics = actions.diagnostics
M.references = actions.references
M.quickfix = actions.quickfix
M.loclist = actions.loclist
M.symbols = actions.symbols

function M.setup()
    -- Reserved for future diagnostics configuration.
end

return M
