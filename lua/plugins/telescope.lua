local keymap = require("utils.keymap")

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

        opts = function()
            local actions = require("telescope.actions")

            return {
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
            }
        end,
    },
}
