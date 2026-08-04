local terminal = require("core.terminal")

local M = {}

--------------------------------------------------------------------------------
-- Repository
--------------------------------------------------------------------------------

function M.open()
    terminal.lazygit()
end

return M
