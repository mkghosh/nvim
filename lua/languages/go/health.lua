local metadata = require("languages.go.metadata")
local tools = require("languages.tools")

local M = {}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

function M.check()
    vim.health.start("Go")

    tools.check_all(metadata.tools)
end

return M
