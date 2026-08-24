local M = {}

local search = require("core.search")

--------------------------------------------------------------------------------
-- Definition / Declaration
--------------------------------------------------------------------------------

function M.definition()
    vim.lsp.buf.definition()
end

function M.declaration()
    vim.lsp.buf.declaration()
end

function M.implementation()
    vim.lsp.buf.implementation()
end

function M.type_definition()
    vim.lsp.buf.type_definition()
end

--------------------------------------------------------------------------------
-- References
--------------------------------------------------------------------------------

function M.references()
    vim.lsp.buf.references()
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
    vim.lsp.buf.typehierarchy()
end

return M
