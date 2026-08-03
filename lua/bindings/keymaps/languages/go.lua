local go = require("languages.go")

return {

    {
        lhs = "<leader>r",
        rhs = go.run,
        desc = "Go: Run",
    },

    {
        lhs = "<leader>T",
        rhs = go.test,
        desc = "Go: Test Package",
    },

    {
        lhs = "<leader>tf",
        rhs = go.test_file,
        desc = "Go: Test File",
    },

    {
        lhs = "<leader>mt",
        rhs = go.mod_tidy,
        desc = "Go: Mod Tidy",
    },

    {
        lhs = "<leader>mg",
        rhs = go.generate,
        desc = "Go: Generate",
    },

    {
        lhs = "<leader>mv",
        rhs = go.vet,
        desc = "Go: Vet",
    },
}
