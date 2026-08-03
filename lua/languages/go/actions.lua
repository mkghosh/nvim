local formatter = require("core.formatter")

local health = require("languages.go.health")
local metadata = require("languages.go.metadata")
local runner = require("languages.tasks.runner")
local workspace = require("languages.go.workspace")

local M = {}

--------------------------------------------------------------------------------
-- Private
--------------------------------------------------------------------------------

---@param task TaskDefinition
local function run(task)
    runner.run(
        workspace.root(),
        task,
        "Go"
    )
end

--------------------------------------------------------------------------------
-- Run
--------------------------------------------------------------------------------

function M.run()
    run(metadata.tasks.run)
end

--------------------------------------------------------------------------------
-- Test
--------------------------------------------------------------------------------

function M.test()
    run(metadata.tasks.test)
end

function M.test_file()
    run(metadata.tasks.test_file)
end

--------------------------------------------------------------------------------
-- Modules
--------------------------------------------------------------------------------

function M.mod_tidy()
    run(metadata.tasks.mod_tidy)
end

--------------------------------------------------------------------------------
-- Generate
--------------------------------------------------------------------------------

function M.generate()
    run(metadata.tasks.generate)
end

--------------------------------------------------------------------------------
-- Vet
--------------------------------------------------------------------------------

function M.vet()
    run(metadata.tasks.vet)
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
