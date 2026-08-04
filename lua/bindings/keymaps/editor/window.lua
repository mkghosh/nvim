local window = require("core.window")

return {

    ----------------------------------------------------------------------------
    -- Split
    ----------------------------------------------------------------------------

    {
        lhs = "<leader>wv",
        rhs = window.vsplit,
        desc = "Window: Vertical Split",
    },

    {
        lhs = "<leader>ws",
        rhs = window.split,
        desc = "Window: Horizontal Split",
    },

    ----------------------------------------------------------------------------
    -- Close
    ----------------------------------------------------------------------------

    {
        lhs = "<leader>wc",
        rhs = window.close,
        desc = "Window: Close",
    },

    {
        lhs = "<leader>wo",
        rhs = window.only,
        desc = "Window: Only",
    },

    ----------------------------------------------------------------------------
    -- Navigation
    ----------------------------------------------------------------------------

    {
        lhs = "<leader>wh",
        rhs = window.left,
        desc = "Window: Left",
    },

    {
        lhs = "<leader>wj",
        rhs = window.down,
        desc = "Window: Down",
    },

    {
        lhs = "<leader>wk",
        rhs = window.up,
        desc = "Window: Up",
    },

    {
        lhs = "<leader>wl",
        rhs = window.right,
        desc = "Window: Right",
    },

    ----------------------------------------------------------------------------
    -- Resize
    ----------------------------------------------------------------------------

    {
        lhs = "<leader>w=",
        rhs = window.equalize,
        desc = "Window: Equalize",
    },

}
