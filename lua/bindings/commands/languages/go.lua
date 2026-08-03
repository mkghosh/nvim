local go = require("languages.go")

return {

    {
        name = "GoRun",
        callback = go.run,
        desc = "Run Go application",
    },

    {
        name = "GoTest",
        callback = go.test,
        desc = "Run all Go tests",
    },

    {
        name = "GoTestFile",
        callback = go.test_file,
        desc = "Run tests in current package",
    },

    {
        name = "GoModTidy",
        callback = go.mod_tidy,
        desc = "Run go mod tidy",
    },

    {
        name = "GoGenerate",
        callback = go.generate,
        desc = "Run go generate",
    },

    {
        name = "GoVet",
        callback = go.vet,
        desc = "Run go vet",
    },

    {
        name = "GoFmt",
        callback = go.format,
        desc = "Format Go buffer",
    },

    {
        name = "GoHealth",
        callback = go.health,
        desc = "Check Go environment",
    },
}
