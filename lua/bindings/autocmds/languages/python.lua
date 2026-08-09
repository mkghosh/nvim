local autocmds = {

    {
        event = {
            "BufReadPost",
            "BufNewFile",
        },

        pattern = "*.py",

        callback = function()
            require("languages.python").setup()
        end,

        desc = "Setup Python",
    },

}

return autocmds
