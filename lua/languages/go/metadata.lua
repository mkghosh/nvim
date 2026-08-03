local M = {}

--------------------------------------------------------------------------------
-- Language
--------------------------------------------------------------------------------

M.filetypes = {
    "go",
    "gomod",
    "gowork",
    "gotmpl",
}

M.root_markers = {
    "go.work",
    "go.mod",
    ".git",
}

--------------------------------------------------------------------------------
-- Toolchain
--------------------------------------------------------------------------------

M.tools = {

    lsp = "gopls",

    dap = "dlv",

    formatter = {
        "goimports",
        "gofumpt",
    },

    linter = {
        "golangci-lint",
    },
}

--------------------------------------------------------------------------------
-- Tasks
--------------------------------------------------------------------------------

M.tasks = {

    run = {
        title = "Go: Run",

        go = "run .",
        make = "run-server",
    },

    test = {
        title = "Go: Test",

        go = "test ./...",
        make = "test",
    },

    test_file = {
        title = "Go: Test File",

        go = "test",
    },

    mod_tidy = {
        title = "Go: Mod Tidy",

        go = "mod tidy",
        make = "tidy",
    },

    generate = {
        title = "Go: Generate",

        go = "generate ./...",
        make = "proto",
    },

    vet = {
        title = "Go: Vet",

        go = "vet ./...",
        make = "vet",
    },
}

return M
