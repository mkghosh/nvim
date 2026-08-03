local M = {}

function M.setup()
    ----------------------------------------------------------------------
    -- Treesitter Folding
    ----------------------------------------------------------------------

    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

    -- Open all folds by default
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99

    -- Optional
    vim.o.foldenable = true
end

function M.enable()
    vim.wo.foldenable = true
end

function M.disable()
    vim.wo.foldenable = false
end

function M.toggle()
    vim.wo.foldenable = not vim.wo.foldenable
end

function M.open_all()
    vim.cmd.normal("zR")
end

function M.close_all()
    vim.cmd.normal("zM")
end

return M
