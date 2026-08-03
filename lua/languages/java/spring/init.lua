local M = {}

local project = require("languages.java.spring.project")

function M.setup()
    if not project.exists() then
        return
    end

    require("languages.java.spring.commands").setup()
    require("languages.java.spring.keymaps").setup()
    require("languages.java.spring.autocmds").setup()
end

return M
