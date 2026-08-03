local M = {}

local project = require("languages.java.project")

function M.run()
    project.run({
        id = "spring",
        title = "Spring Boot",
        layout = "bottom",

        maven = {
            "spring-boot:run",
        },

        gradle = {
            "bootRun",
        },
    })
end

function M.debug()
    project.run({
        id = "spring-debug",
        title = "Spring Boot Debug",
        layout = "bottom",

        maven = {
            "-Dspring-boot.run.jvmArguments=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005",
            "spring-boot:run",
        },

        gradle = {
            "--debug-jvm",
            "bootRun",
        },
    })
end

return M
