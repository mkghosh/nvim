local actions = require("languages.python.actions")

local M = {}

--------------------------------------------------------------------------------
-- Actions
--------------------------------------------------------------------------------

M.run = actions.run
M.test = actions.test
M.format = actions.format
M.health = actions.health

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

function M.setup()

end

return M
