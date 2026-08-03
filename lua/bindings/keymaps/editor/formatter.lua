local formatter = require("core.formatter")

return {
    {
        mode = { "n", "v" },
        lhs = "<leader>cf",
        rhs = formatter.format,
        desc = "Code: Format",
    },
}
