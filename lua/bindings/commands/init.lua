local command = require("utils.command")

local M = {}

local modules = {
    -- Editor
    -- "editor.git",
    -- "editor.debugger",

    -- Languages
    "languages.go",
    "languages.java",
}

function M.setup()
    for _, module in ipairs(modules) do
        command.module("bindings.commands." .. module)
    end
end

return M
