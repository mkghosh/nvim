local M = {}

local search = require("core.search")

local function telescope()
    return require("telescope.builtin")
end

--------------------------------------------------------------------------------
-- Definition / Declaration
--------------------------------------------------------------------------------

function M.definition()
    telescope().lsp_definitions()
end

function M.declaration()
    vim.lsp.buf.declaration()
end

function M.implementation()
    telescope().lsp_implementations()
end

function M.type_definition()
    telescope().lsp_type_definitions()
end

--------------------------------------------------------------------------------
-- References
--------------------------------------------------------------------------------

function M.references()
    telescope().lsp_references()
end

--------------------------------------------------------------------------------
-- Symbols
--------------------------------------------------------------------------------

function M.document_symbols()
    search.document_symbols()
end

function M.workspace_symbols()
    search.workspace_symbols()
end

--------------------------------------------------------------------------------
-- Call Hierarchy
--------------------------------------------------------------------------------

function M.incoming_calls()
    vim.lsp.buf.incoming_calls()
end

function M.outgoing_calls()
    vim.lsp.buf.outgoing_calls()
end

--------------------------------------------------------------------------------
-- Type Hierarchy
--------------------------------------------------------------------------------

function M.type_hierarchy()
    vim.lsp.buf.typehierarchy("supertypes")
end

return M
