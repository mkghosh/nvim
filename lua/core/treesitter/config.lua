local M = {}

M.ensure_installed = require("core.treesitter.parsers")

M.highlight = {
    enable = true,
}

M.indent = {
    enable = true,
}

M.incremental_selection = {

    enable = true,

    keymaps = {
        init_selection = "<leader>ts",
        node_incremental = "<leader>te",
        node_decremental = "<leader>td",
        scope_incremental = false,
    },
}

M.textobjects = require("core.treesitter.textobjects")

return M
