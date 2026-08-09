local actions = require("languages.python.actions")
local dap = require("languages.python.dap")

local M = {}

--------------------------------------------------------------------------------
-- Actions
--------------------------------------------------------------------------------

M.run = actions.run
M.test = actions.test
M.format = actions.format
M.health = actions.health
M.debug = actions.debug

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

function M.setup()
    dap.setup()
end

return M
