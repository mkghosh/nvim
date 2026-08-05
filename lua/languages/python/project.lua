local metadata = require("languages.python.metadata")

local M = {}

--------------------------------------------------------------------------------
-- Root
--------------------------------------------------------------------------------

function M.root()
    return vim.fs.root(0, metadata.root_markers)
end

--------------------------------------------------------------------------------
-- Project System
--------------------------------------------------------------------------------

function M.system()
    local root = M.root()

    if not root then
        return nil
    end

    local markers = {

        uv = "uv.lock",

        poetry = "poetry.lock",

        pipenv = "Pipfile",

        pip = "requirements.txt",

        setuptools = "setup.py",

    }

    for system, marker in pairs(markers) do
        if vim.uv.fs_stat(vim.fs.joinpath(root, marker)) then
            return system
        end
    end

    return "python"
end

--------------------------------------------------------------------------------
-- Virtual Environment
--------------------------------------------------------------------------------

function M.venv()
    local root = M.root()

    if not root then
        return nil
    end

    for _, directory in ipairs({
        ".venv",
        "venv",
        "env",
    }) do
        local path = vim.fs.joinpath(root, directory)

        if vim.fn.isdirectory(path) == 1 then
            return path
        end
    end

    return nil
end

--------------------------------------------------------------------------------
-- Python Interpreter
--------------------------------------------------------------------------------

function M.python()
    local venv = M.venv()

    if venv then
        return vim.fs.joinpath(
            venv,
            "bin",
            "python"
        )
    end

    return vim.fn.exepath("python3")
end

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

function M.is_uv()
    return M.system() == "uv"
end

function M.is_poetry()
    return M.system() == "poetry"
end

function M.is_pip()
    return M.system() == "pip"
end

function M.is_pipenv()
    return M.system() == "pipenv"
end

--------------------------------------------------------------------------------
-- Environment
--------------------------------------------------------------------------------

function M.has_venv()
    return M.venv() ~= nil
end

return M
