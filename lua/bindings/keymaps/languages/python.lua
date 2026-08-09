local python = require("languages.python")

return {

    {
        lhs = "<leader>pr",
        rhs = python.run,
        desc = "Python: Run",
    },

    {
        lhs = "<leader>pt",
        rhs = python.test,
        desc = "Python: Test",
    },

    {
        lhs = "<leader>pd",
        rhs = python.debug,
        desc = "Python: Debug",
    },

    {
        lhs = "<leader>ph",
        rhs = python.health,
        desc = "Python: Health",
    },

}
