local linter = require("core.linter")

return {
    {
        lhs = "<leader>ll",
        rhs = linter.run,
        desc = "Code: Run Linter",
    },
}
