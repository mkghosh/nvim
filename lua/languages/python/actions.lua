local formatter = require("core.formatter")
local debugger = require("core.debugger")
local terminal = require("core.terminal")

local tasks = require("languages.tasks")

local health = require("languages.python.health")
local metadata = require("languages.python.metadata")
local project = require("languages.python.project")

local M = {}

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

local function root()
    return project.root()
end

local function current_file()
    local file = vim.fn.expand("%:p")

    if file == "" then
        vim.notify(
            "No Python file is currently open.",
            vim.log.levels.ERROR
        )
        return nil
    end

    return file
end

--------------------------------------------------------------------------------
-- Run
--------------------------------------------------------------------------------

function M.run()
    local file = current_file()

    if not file then
        return
    end

    local python = project.python()

    if not python or python == "" then
        vim.notify(
            "Python interpreter not found.",
            vim.log.levels.ERROR
        )
        return
    end

    terminal.task(
        vim.fn.shellescape(python)
        .. " "
        .. vim.fn.shellescape(file),
        {
            cwd = root(),
            title = "Python: Run",
        }
    )
end

--------------------------------------------------------------------------------
-- Test
--------------------------------------------------------------------------------

function M.test()
    local project_root = root()

    if not project_root then
        vim.notify(
            "Python project root not found.",
            vim.log.levels.ERROR
        )
        return
    end

    tasks.run(
        project_root,
        metadata.tasks.test
    )
end

--------------------------------------------------------------------------------
-- Format
--------------------------------------------------------------------------------

function M.format()
    formatter.format({
        async = false,
    })
end

--------------------------------------------------------------------------------
-- Debug
--------------------------------------------------------------------------------

function M.debug()
    debugger.continue()
end

--------------------------------------------------------------------------------
-- Health
--------------------------------------------------------------------------------

function M.health()
    health.check()
end

return M
