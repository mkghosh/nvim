local keymap = require("utils.keymap")

return {
    {
        "nvim-neo-tree/neo-tree.nvim",

        branch = "v3.x",

        cmd = "Neotree",
        keys = keymap.module("bindings.keymaps.editor.explorer"),
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },

        opts = {
            close_if_last_window = true,

            popup_border_style = "rounded",

            enable_git_status = true,

            sources = {
                "filesystem",
                "buffers",
                "git_status",
            },

            filesystem = {
                follow_current_file = {
                    enabled = true,
                },

                hijack_netrw_behavior = "open_current",
            },

            window = {
                position = "left",
                width = 35,
            },
        },
    },
}
