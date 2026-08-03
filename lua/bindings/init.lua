local M = {}

function M.setup()
    require("bindings.keymaps").setup()
    require("bindings.commands").setup()
    require("bindings.autocmds").setup()
end

return M
