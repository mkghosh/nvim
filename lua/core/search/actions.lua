local M = {}

--------------------------------------------------------------------------------
-- Private
--------------------------------------------------------------------------------

local function builtin()
    return require("telescope.builtin")
end

--------------------------------------------------------------------------------
-- Files
--------------------------------------------------------------------------------

function M.files()
    builtin().find_files()
end

function M.git_files()
    builtin().git_files()
end

function M.recent_files()
    builtin().oldfiles()
end

function M.buffers()
    builtin().buffers()
end

--------------------------------------------------------------------------------
-- Search
--------------------------------------------------------------------------------

function M.grep()
    builtin().live_grep()
end

function M.word()
    builtin().grep_string()
end

function M.resume()
    builtin().resume()
end

function M.current_buffer()
    builtin().current_buffer_fuzzy_find()
end

--------------------------------------------------------------------------------
-- LSP
--------------------------------------------------------------------------------

function M.document_symbols()
    builtin().lsp_document_symbols()
end

function M.workspace_symbols()
    builtin().lsp_workspace_symbols()
end

function M.diagnostics()
    builtin().diagnostics()
end

--------------------------------------------------------------------------------
-- Lists
--------------------------------------------------------------------------------

function M.quickfix()
    builtin().quickfix()
end

function M.location_list()
    builtin().loclist()
end

--------------------------------------------------------------------------------
-- Neovim
--------------------------------------------------------------------------------

function M.commands()
    builtin().commands()
end

function M.keymaps()
    builtin().keymaps()
end

function M.help()
    builtin().help_tags()
end

--------------------------------------------------------------------------------
-- Treesitter
--------------------------------------------------------------------------------

function M.treesitter()
    builtin().treesitter()
end

return M
