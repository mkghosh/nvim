local M = {}

local actions = require("core.treesitter.actions")

--------------------------------------------------------------------------------
-- Folding
--------------------------------------------------------------------------------

M.enable = actions.enable
M.disable = actions.disable
M.toggle = actions.toggle
M.open_all = actions.open_all
M.close_all = actions.close_all

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

function M.setup()
    require("core.treesitter.folds").setup()
end

return M
