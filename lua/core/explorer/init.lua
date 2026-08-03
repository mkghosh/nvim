local M = {}

local tree = require("core.explorer.actions")
local directory = require("core.explorer.directory")

--------------------------------------------------------------------------------
-- Tree
--------------------------------------------------------------------------------

M.toggle = tree.toggle
M.reveal = tree.reveal
M.focus = tree.focus

M.buffers = tree.buffers
M.git = tree.git
M.diagnostics = tree.diagnostics

--------------------------------------------------------------------------------
-- Directory
--------------------------------------------------------------------------------

M.open = directory.open

return M
