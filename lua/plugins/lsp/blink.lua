return {
    {
        "saghen/blink.cmp",

        version = "1.*",

        dependencies = {
            "rafamadriz/friendly-snippets",
        },

        opts = require("core.completion.config"),

        config = function(_, opts)
            require("blink.cmp").setup(opts)
            require("core.completion").setup()
        end,
    },
}
