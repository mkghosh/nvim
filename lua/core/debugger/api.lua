local dap = require("dap")

local M = {}

function M.continue()
    dap.continue()
end

function M.pause()
    dap.pause()
end

function M.restart()
    dap.restart()
end

function M.terminate()
    dap.terminate()
end

function M.step_into()
    dap.step_into()
end

function M.step_over()
    dap.step_over()
end

function M.step_out()
    dap.step_out()
end

function M.run_last()
    dap.run_last()
end

function M.repl()
    dap.repl.open()
end

function M.toggle_ui()
    require("dapui").toggle()
end

function M.toggle_breakpoint()
    require("core.debugger.breakpoints").toggle()
end

function M.conditional_breakpoint()
    require("core.debugger.breakpoints").conditional()
end

function M.logpoint()
    require("core.debugger.breakpoints").logpoint()
end

function M.clear_breakpoints()
    require("core.debugger.breakpoints").clear()
end

return M
