local dap = require("dap")

local M = {}

function M.toggle()
    dap.toggle_breakpoint()
end

function M.conditional()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end

function M.logpoint()
    dap.set_breakpoint(nil, nil, vim.fn.input("Log message: "))
end

function M.clear()
    dap.clear_breakpoints()
end

return M
