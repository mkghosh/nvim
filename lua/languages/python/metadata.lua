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
-- Toolchain
--------------------------------------------------------------------------------

M.tools = {

    lsp = "basedpyright",

    dap = "debugpy",

    formatter = {
        "ruff",
    },

    linter = {
        "ruff",
    },
}

--------------------------------------------------------------------------------
-- Tasks
--------------------------------------------------------------------------------

M.tasks = {

    run = {

        title = "Python: Run",

        uv = "run main.py",

        poetry = "run python main.py",

        pip = "main.py",
    },

    test = {

        title = "Python: Test",

        uv = "run pytest",

        poetry = "run pytest",

        pip = "-m pytest",
    },

}

return M
