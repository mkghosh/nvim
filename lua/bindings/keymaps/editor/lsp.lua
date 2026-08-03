local keymap = require("utils.keymap")
local border = require("utils.border")

local trouble = require("core.diagnostics")
local hints = require("lsp.inlay_hints")

local M = {}

function M.attach(bufnr)
    keymap.set_buffer(bufnr, {

        ----------------------------------------------------------------------
        -- Navigation
        ----------------------------------------------------------------------

        {
            lhs = "gd",
            rhs = vim.lsp.buf.definition,
            desc = "LSP: Goto Definition",
        },

        {
            lhs = "gD",
            rhs = vim.lsp.buf.declaration,
            desc = "LSP: Goto Declaration",
        },

        {
            lhs = "gr",
            rhs = vim.lsp.buf.references,
            desc = "LSP: Goto References",
        },

        {
            lhs = "gi",
            rhs = vim.lsp.buf.implementation,
            desc = "LSP: Goto Implementation",
        },

        {
            lhs = "gt",
            rhs = vim.lsp.buf.type_definition,
            desc = "LSP: Goto Type Definition",
        },

        ----------------------------------------------------------------------
        -- Information
        ----------------------------------------------------------------------

        {
            lhs = "K",
            rhs = function()
                vim.lsp.buf.hover({ border = border })
            end,
            desc = "LSP: Hover",
        },

        {
            lhs = "<leader>ls",
            rhs = vim.lsp.buf.signature_help,
            desc = "LSP: Signature Help",
        },

        ----------------------------------------------------------------------
        -- Actions
        ----------------------------------------------------------------------

        {
            lhs = "<leader>la",
            rhs = vim.lsp.buf.code_action,
            desc = "LSP: Code Action",
        },

        {
            lhs = "<leader>ln",
            rhs = vim.lsp.buf.rename,
            desc = "LSP: Rename",
        },

        {
            lhs = "<leader>lf",
            rhs = function()
                vim.lsp.buf.format({ async = true })
            end,
            desc = "LSP: Format",
        },

        ----------------------------------------------------------------------
        -- Diagnostics
        ----------------------------------------------------------------------

        {
            lhs = "]d",
            rhs = function()
                vim.diagnostic.jump({ count = 1, float = true })
            end,
            desc = "LSP: Next Diagnostic",
        },

        {
            lhs = "[d",
            rhs = function()
                vim.diagnostic.jump({ count = -1, float = true })
            end,
            desc = "LSP: Previous Diagnostic",
        },

        {
            lhs = "<leader>le",
            rhs = function()
                vim.diagnostic.open_float({ border = border })
            end,
            desc = "LSP: Line Diagnostics",
        },

        ----------------------------------------------------------------------
        -- Trouble
        ----------------------------------------------------------------------

        {
            lhs = "<leader>ld",
            rhs = trouble.diagnostics,
            desc = "LSP: Diagnostics",
        },

        {
            lhs = "<leader>lr",
            rhs = trouble.references,
            desc = "LSP: References",
        },

        {
            lhs = "<leader>lq",
            rhs = trouble.quickfix,
            desc = "LSP: Quickfix",
        },

        {
            lhs = "<leader>ll",
            rhs = trouble.loclist,
            desc = "LSP: Location List",
        },

        ----------------------------------------------------------------------
        -- Symbols
        ----------------------------------------------------------------------

        {
            lhs = "<leader>lo",
            rhs = function()
                trouble.symbols("symbols")
            end,
            desc = "LSP: Document Symbols",
        },

        {
            lhs = "<leader>lw",
            rhs = function()
                trouble.symbols("lsp_workspace_symbols")
            end,
            desc = "LSP: Workspace Symbols",
        },

        ----------------------------------------------------------------------
        -- Server
        ----------------------------------------------------------------------

        {
            lhs = "<leader>li",
            rhs = "<cmd>LspInfo<CR>",
            desc = "LSP: Info",
        },

        {
            lhs = "<leader>lR",
            rhs = "<cmd>LspRestart<CR>",
            desc = "LSP: Restart",
        },

        {
            lhs = "<leader>lI",
            rhs = hints.toggle,
            desc = "LSP: Toggle Inlay Hints",
        },

    })
end

return M
