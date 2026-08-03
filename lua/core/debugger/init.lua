local M = {}

local api = require("core.debugger.api")

----------------------------------------------------------------------
-- Setup
----------------------------------------------------------------------

function M.setup()
    require("core.debugger.signs").setup()
    require("core.debugger.listeners").setup()
    require("core.debugger.adapters").setup()
end

----------------------------------------------------------------------
-- Execution
----------------------------------------------------------------------

M.continue = api.continue
M.pause = api.pause
M.restart = api.restart
M.terminate = api.terminate

M.step_into = api.step_into
M.step_over = api.step_over
M.step_out = api.step_out

M.run_last = api.run_last
M.repl = api.repl

----------------------------------------------------------------------
-- UI
----------------------------------------------------------------------

M.toggle_ui = api.toggle_ui

----------------------------------------------------------------------
-- Breakpoints
----------------------------------------------------------------------

M.toggle_breakpoint = api.toggle_breakpoint
M.conditional_breakpoint = api.conditional_breakpoint
M.logpoint = api.logpoint
M.clear_breakpoints = api.clear_breakpoints

return M
