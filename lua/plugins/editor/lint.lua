local keymap = require("utils.keymap")

return {
    {
        "mfussenegger/nvim-lint",

        event = {
            "BufReadPost",
            "BufNewFile",
        },

        keys = keymap.module("bindings.keymaps.editor.linter"),

        opts = require("core.linter.config"),

        config = function(_, opts)
            require("lint").linters_by_ft = opts.linters_by_ft
        end,
    },
}
