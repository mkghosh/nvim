local M = {}

local launcher = require("core.terminal.launcher")
local tools = require("core.terminal.tools")

function M.setup()
end

----------------------------------------------------------------------
-- Launcher
----------------------------------------------------------------------

M.run = launcher.run
M.task = launcher.task
M.float = launcher.float
M.side = launcher.side

M.toggle = launcher.toggle
M.open = launcher.open
M.focus = launcher.focus
M.list = launcher.list

----------------------------------------------------------------------
-- Tools
----------------------------------------------------------------------

M.shell = tools.shell
M.lazygit = tools.lazygit
M.htop = tools.htop
M.btop = tools.btop
M.lazydocker = tools.lazydocker
M.k9s = tools.k9s
M.yazi = tools.yazi

return M
