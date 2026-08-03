local keymap = require("utils.keymap")
local actions = require("telescope.actions")

return {
    {
        "nvim-telescope/telescope.nvim",

        keys = keymap.module("bindings.keymaps.editor.search"),

        dependencies = {
            "nvim-lua/plenary.nvim",

            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },

        opts = {
            defaults = {
                sorting_strategy = "ascending",

                layout_config = {
                    prompt_position = "top",
                },

                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                },
            },
        },
    },
}
