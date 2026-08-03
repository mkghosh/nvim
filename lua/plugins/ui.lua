return {
    {
        "folke/tokyonight.nvim",

        priority = 1000,
        lazy = false,

        opts = {},

        config = function()
            vim.cmd.colorscheme("tokyonight")
        end,
    },

    {
        "folke/which-key.nvim",

        event = "VeryLazy",

        config = function()
            require("utils.which-key").setup()
        end,
    },

    {
        "nvim-tree/nvim-web-devicons",
    },

    {
        "nvim-lualine/lualine.nvim",

        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },

        opts = {
            options = {
                theme = "tokyonight",
            },
        },
    },
}
