local M = {}

local folds = require("core.treesitter.folds")

--------------------------------------------------------------------------------
-- Folding
--------------------------------------------------------------------------------

M.enable = folds.enable
M.disable = folds.disable
M.toggle = folds.toggle
M.open_all = folds.open_all
M.close_all = folds.close_all

return M
