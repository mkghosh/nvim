local autocmd = require("utils.autocmd")

local M = {}

local modules = {
    "lsp",
    "linter",
    "languages",
}

function M.setup()
    for _, module in ipairs(modules) do
        autocmd.module("bindings.autocmds." .. module)
    end
end

return M
