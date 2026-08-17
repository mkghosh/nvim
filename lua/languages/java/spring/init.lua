local M = {}

local project = require("languages.java.spring.project")

function M.setup()
    if not project.exists() then
        return
    end
end

return M
