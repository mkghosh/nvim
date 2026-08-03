local keymap = require("utils.keymap")

return {
    {
        "lewis6991/gitsigns.nvim",

        event = { "BufReadPre", "BufNewFile" },

        keys = keymap.module("bindings.keymaps.editor.git"),

        opts = {},
    },

    {
        "sindrets/diffview.nvim",

        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewFileHistory",
        },
    },
}
