local M = {}

local autocmd = require("utils.autocmd")
local project = require("languages.java.spring.project")

local initialized = false

function M.setup()
    if initialized then
        return
    end

    initialized = true

    local group = autocmd.group("JavaSpring", {
        clear = true,
    })

    autocmd.create("BufWritePost", {
        group = group,
        pattern = {
            "pom.xml",
            "build.gradle",
            "build.gradle.kts",
        },
        callback = project.invalidate,
    })
end

return M
