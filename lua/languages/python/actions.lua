local formatter = require("core.formatter")

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

--------------------------------------------------------------------------------
-- Run
--------------------------------------------------------------------------------

function M.run()
    tasks.run(
        root(),
        metadata.tasks.run
    )
end

--------------------------------------------------------------------------------
-- Test
--------------------------------------------------------------------------------

function M.test()
    tasks.run(
        root(),
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
-- Health
--------------------------------------------------------------------------------

function M.health()
    health.check()
end

return M
