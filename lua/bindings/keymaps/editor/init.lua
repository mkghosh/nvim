local M = {}

local keymap = require("utils.keymap")

local modules = {
    "terminal",
    "debugger",
    "navigation",
    "formatter",
    "window",
    "tab",
    -- "finder",
    "treesitter",
}

function M.setup()
    for _, module in ipairs(modules) do
        keymap.set_all(require("bindings.keymaps.editor." .. module))
    end
end

return M
