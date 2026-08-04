local M = {}

local command = require("utils.command")
local run = require("languages.java.spring.run")

local initialized = false

function M.setup()
    if initialized then
        return
    end

    initialized = true

    command.create_all({
        {
            name = "SpringRun",
            callback = run.run,
            desc = "Run Spring Boot",
        },
        {
            name = "SpringDebug",
            callback = run.debug,
            desc = "Debug Spring Boot",
        },
    })
end

return M
