local autocmd = require("utils.autocmd")

local M = {}

local modules = {
    "lsp",
    "linter",
}

function M.setup()
    for _, module in ipairs(modules) do
        autocmd.module("bindings.autocmds." .. module)
    end

    require("bindings.autocmds.languages").setup()
end

return M
