local M = {}

function M.setup()
    local wk = require("which-key")

    wk.add({
        { "<leader>e",  group = "Explorer" },
        { "<leader>f",  group = "Find" },
        { "<leader>g",  group = "Git" },
        { "<leader>h",  group = "Harpoon" },
        { "<leader>l",  group = "LSP" },
        { "<leader>t",  group = "Terminal" },
        { "<leader>x",  group = "Trouble" },
        { "<leader>j",  group = "Java" },
        { "<leader>jc", group = "Workspace" },
        { "<leader>jp", group = "Project" },
        { "<leader>jr", group = "Refactor" },
        { "<leader>jt", group = "JavaTest" },
        { "<leader>js", group = "Spring" },
        { "<leader>z",  group = "Folds" },
    })
end

return M
