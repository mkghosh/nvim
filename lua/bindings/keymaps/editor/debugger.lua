local debugger = require("core.debugger")

return {

    ----------------------------------------------------------------------
    -- Execution
    ----------------------------------------------------------------------

    {
        lhs = "<F5>",
        rhs = debugger.continue,
        desc = "DAP: Continue",
    },

    {
        lhs = "<F6>",
        rhs = debugger.pause,
        desc = "DAP: Pause",
    },

    {
        lhs = "<F7>",
        rhs = debugger.restart,
        desc = "DAP: Restart",
    },

    {
        lhs = "<F10>",
        rhs = debugger.step_over,
        desc = "DAP: Step Over",
    },

    {
        lhs = "<F11>",
        rhs = debugger.step_into,
        desc = "DAP: Step Into",
    },

    {
        lhs = "<S-F11>",
        rhs = debugger.step_out,
        desc = "DAP: Step Out",
    },

    ----------------------------------------------------------------------
    -- Breakpoints
    ----------------------------------------------------------------------

    {
        lhs = "<F9>",
        rhs = debugger.toggle_breakpoint,
        desc = "DAP: Toggle Breakpoint",
    },

    {
        lhs = "<leader>dB",
        rhs = debugger.conditional_breakpoint,
        desc = "DAP: Conditional Breakpoint",
    },

    {
        lhs = "<leader>dl",
        rhs = debugger.logpoint,
        desc = "DAP: Log Point",
    },

    {
        lhs = "<leader>dC",
        rhs = debugger.clear_breakpoints,
        desc = "DAP: Clear Breakpoints",
    },

    ----------------------------------------------------------------------
    -- UI
    ----------------------------------------------------------------------

    {
        lhs = "<leader>du",
        rhs = debugger.toggle_ui,
        desc = "DAP: Toggle UI",
    },

    {
        lhs = "<leader>dr",
        rhs = debugger.repl,
        desc = "DAP: REPL",
    },

    ----------------------------------------------------------------------
    -- Session
    ----------------------------------------------------------------------

    {
        lhs = "<leader>dx",
        rhs = debugger.terminate,
        desc = "DAP: Terminate",
    },

    {
        lhs = "<leader>dR",
        rhs = debugger.run_last,
        desc = "DAP: Run Last",
    },
}
