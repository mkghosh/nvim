local formatter = require("core.formatter")

local health = require("languages.java.health")
local metadata = require("languages.java.metadata")
local project = require("languages.java.project")
local tasks = require("languages.tasks")

local M = {}

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

---@param task TaskDefinition
local function run(task)
    local root = project.root()

    if not root then
        vim.notify(
            "Not inside a Java project.",
            vim.log.levels.ERROR
        )
        return
    end

    local resolved = project.task(task)

    if not resolved then
        vim.notify(
            "Unable to resolve Java build task.",
            vim.log.levels.ERROR
        )
        return
    end

    tasks.run(root, resolved)
end

--------------------------------------------------------------------------------
-- Project
--------------------------------------------------------------------------------

function M.build()
    run(metadata.tasks.build)
end

function M.clean()
    run(metadata.tasks.clean)
end

function M.install()
    run(metadata.tasks.install)
end

function M.test()
    run(metadata.tasks.test)
end

--------------------------------------------------------------------------------
-- Formatting
--------------------------------------------------------------------------------

function M.format()
    formatter.format({
        async = false,
    })
end

--------------------------------------------------------------------------------
-- Health
--------------------------------------------------------------------------------

function M.health()
    health.check()
end

return M
