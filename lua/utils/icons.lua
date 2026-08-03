local M = {}

M.diagnostics = {
    Error = "",
    Warn  = "",
    Info  = "",
    Hint  = "󰌵",
}

M.git = {
    Added    = "",
    Modified = "",
    Removed  = "",
}

M.dap = {
    Breakpoint          = "",
    BreakpointCondition = "",
    BreakpointRejected  = "",
    LogPoint            = "",
    Stopped             = "",
}

M.kind = {
    Class     = "󰠱",
    Method    = "󰆧",
    Function  = "󰊕",
    Variable  = "󰀫",
    Interface = "",
    Module    = "󰏗",
}

return M
