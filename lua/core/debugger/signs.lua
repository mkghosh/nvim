local icons = require("utils.icons")

local M = {}

local signs = {
    DapBreakpoint = {
        text = icons.dap.Breakpoint,
        texthl = "DiagnosticSignError",
    },

    DapBreakpointCondition = {
        text = icons.dap.BreakpointCondition,
        texthl = "DiagnosticSignWarn",
    },

    DapBreakpointRejected = {
        text = icons.dap.BreakpointRejected,
        texthl = "DiagnosticSignWarn",
    },

    DapLogPoint = {
        text = icons.dap.LogPoint,
        texthl = "DiagnosticSignInfo",
    },

    DapStopped = {
        text = icons.dap.Stopped,
        texthl = "DiagnosticSignInfo",
        linehl = "Visual",
        numhl = "DiagnosticSignInfo",
    },
}

function M.setup()
    for name, sign in pairs(signs) do
        vim.fn.sign_define(name, sign)
    end
end

return M
