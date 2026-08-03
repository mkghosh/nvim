local M = {}

function M.setup()
    local wk = require("which-key")

    wk.add({
        { "<leader>e", group = "Explorer" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Harpoon" },
        { "<leader>l", group = "LSP" },
        { "<leader>t", group = "Terminal" },
        { "<leader>x", group = "Trouble" },
        { "<leader>j", group = "Java" },
        { "<leader>z", group = "Folds" },
    })
end

return M
