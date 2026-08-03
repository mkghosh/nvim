return {
    {
        "stevearc/conform.nvim",

        event = {
            "BufReadPre",
            "BufNewFile",
        },

        opts = require("core.formatter.config"),
    },
}
