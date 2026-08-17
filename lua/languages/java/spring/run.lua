local project = require("languages.java.project")
local tasks = require("languages.tasks")

local M = {}

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

---@param task TaskDefinition
---@param opts? TerminalTaskOptions
local function run(task, opts)
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
            "Unable to resolve Spring Boot task.",
            vim.log.levels.ERROR
        )
        return
    end

    tasks.run(root, resolved, opts)
end

--------------------------------------------------------------------------------
-- Run
--------------------------------------------------------------------------------

function M.run()
    run(
        {
            title = "Spring Boot",

            maven = "spring-boot:run",

            gradle = "bootRun",
        },
        {
            id = "spring",
            title = "Spring Boot",
            layout = "bottom",
        }
    )
end

--------------------------------------------------------------------------------
-- Debug
--------------------------------------------------------------------------------

function M.debug()
    run(
        {
            title = "Spring Boot Debug",

            maven =
                "-Dspring-boot.run.jvmArguments="
                .. "-agentlib:jdwp=transport=dt_socket,"
                .. "server=y,suspend=n,address=*:5005 "
                .. "spring-boot:run",

            gradle = "--debug-jvm bootRun",
        },
        {
            id = "spring-debug",
            title = "Spring Boot Debug",
            layout = "bottom",
        }
    )
end

return M
