local M = {}

local actions = require("core.search.actions")

--------------------------------------------------------------------------------
-- Files
--------------------------------------------------------------------------------

M.files = actions.files
M.git_files = actions.git_files
M.recent_files = actions.recent_files
M.buffers = actions.buffers

--------------------------------------------------------------------------------
-- Search
--------------------------------------------------------------------------------

M.grep = actions.grep
M.word = actions.word
M.resume = actions.resume
M.current_buffer = actions.current_buffer

--------------------------------------------------------------------------------
-- LSP
--------------------------------------------------------------------------------

M.document_symbols = actions.document_symbols
M.workspace_symbols = actions.workspace_symbols
M.diagnostics = actions.diagnostics

--------------------------------------------------------------------------------
-- Lists
--------------------------------------------------------------------------------

M.quickfix = actions.quickfix
M.location_list = actions.location_list

--------------------------------------------------------------------------------
-- Neovim
--------------------------------------------------------------------------------

M.commands = actions.commands
M.keymaps = actions.keymaps
M.help = actions.help

--------------------------------------------------------------------------------
-- Treesitter
--------------------------------------------------------------------------------

M.treesitter = actions.treesitter

return M
