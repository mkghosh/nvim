local linter = require("core.linter")

return {
    {
        event = {
            "BufEnter",
            "BufWritePost",
            "InsertLeave",
        },

        callback = linter.run,

        desc = "Run linter",
    },
}
