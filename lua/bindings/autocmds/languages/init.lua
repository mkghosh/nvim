local autocmd = require("utils.autocmd")

local M = {}

local modules = {
    "java",
    "python",
}

function M.setup()
    for _, module in ipairs(modules) do
        autocmd.module("bindings.autocmds.languages." .. module)
    end
end

return M
