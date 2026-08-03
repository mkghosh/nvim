local border = require("utils.border")

local M = {}

M.opts = {
    floating = {
        border = border,
    },

    layouts = {
        {
            position = "left",
            size = 40,

            elements = {
                { id = "scopes", size = 0.35 },
                { id = "breakpoints", size = 0.15 },
                { id = "stacks", size = 0.25 },
                { id = "watches", size = 0.25 },
            },
        },

        {
            position = "bottom",
            size = 10,

            elements = {
                "repl",
                "console",
            },
        },
    },

    controls = {
        enabled = true,
    },
}

return M
