local M = {}

--------------------------------------------------------------------------------
-- Language
--------------------------------------------------------------------------------

M.filetypes = {
    "python",
}

M.root_markers = {
    "pyproject.toml",
    "uv.lock",
    "poetry.lock",
    "Pipfile",
    "requirements.txt",
    "setup.py",
    ".git",
}

--------------------------------------------------------------------------------
-- Tools
--------------------------------------------------------------------------------

M.tools = {

    lsp = "basedpyright",

    formatter = {
        "ruff",
    },

    linter = {
        "ruff",
    },

    debugger = "debugpy",

    test = "pytest",

    notebook = "jupyter",
}

--------------------------------------------------------------------------------
-- Tasks
--------------------------------------------------------------------------------

M.tasks = {

    run = {

        title = "Run",

        uv = "run main.py",

        poetry = "run python main.py",

        pip = "main.py",
    },

    test = {

        title = "Test",

        uv = "run pytest",

        poetry = "run pytest",

        pip = "-m pytest",
    },

}

return M
