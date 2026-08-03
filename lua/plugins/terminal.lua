return {
    {
        "folke/snacks.nvim",

        priority = 1000,
        lazy = false,

        opts = {
            terminal = {
                enabled = true,
            },
        },

        config = function(_, opts)
            require("snacks").setup(opts)
            require("core.terminal").setup()
        end,
    },
}
