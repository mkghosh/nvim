local actions = require("languages.go.actions")

local M = {}

--------------------------------------------------------------------------------
-- Actions
--------------------------------------------------------------------------------

M.run = actions.run
M.test = actions.test
M.test_file = actions.test_file

M.mod_tidy = actions.mod_tidy

M.generate = actions.generate

M.vet = actions.vet

M.format = actions.format

M.health = actions.health

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

function M.setup()
    require("languages.go.dap").setup()
end

return M
