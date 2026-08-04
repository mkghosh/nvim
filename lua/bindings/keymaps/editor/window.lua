local window = require("core.window")

return {

    ----------------------------------------------------------------------------
    -- Split
    ----------------------------------------------------------------------------

    {
        lhs = "<leader>ws",
        rhs = window.split,
        desc = "Window: Horizontal Split",
    },

    {
        lhs = "<leader>wv",
        rhs = window.vsplit,
        desc = "Window: Vertical Split",
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
    -- Move Window
    ----------------------------------------------------------------------------

    {
        lhs = "<leader>wH",
        rhs = window.move_left,
        desc = "Window: Move Left",
    },

    {
        lhs = "<leader>wJ",
        rhs = window.move_down,
        desc = "Window: Move Down",
    },

    {
        lhs = "<leader>wK",
        rhs = window.move_up,
        desc = "Window: Move Up",
    },

    {
        lhs = "<leader>wL",
        rhs = window.move_right,
        desc = "Window: Move Right",
    },

    ----------------------------------------------------------------------------
    -- Resize
    ----------------------------------------------------------------------------

    {
        lhs = "<leader>w=",
        rhs = window.equalize,
        desc = "Window: Equalize",
    },

    {
        lhs = "<leader>w>",
        rhs = window.increase_width,
        desc = "Window: Increase Width",
    },

    {
        lhs = "<leader>w<",
        rhs = window.decrease_width,
        desc = "Window: Decrease Width",
    },

    {
        lhs = "<leader>w+",
        rhs = window.increase_height,
        desc = "Window: Increase Height",
    },

    {
        lhs = "<leader>w-",
        rhs = window.decrease_height,
        desc = "Window: Decrease Height",
    },

    ----------------------------------------------------------------------------
    -- Rotation
    ----------------------------------------------------------------------------

    {
        lhs = "<leader>wr",
        rhs = window.rotate_down,
        desc = "Window: Rotate Down",
    },

    {
        lhs = "<leader>wR",
        rhs = window.rotate_up,
        desc = "Window: Rotate Up",
    },

    ----------------------------------------------------------------------------
    -- Cycling
    ----------------------------------------------------------------------------

    {
        lhs = "<leader>ww",
        rhs = window.next,
        desc = "Window: Next",
    },

    {
        lhs = "<leader>wW",
        rhs = window.previous,
        desc = "Window: Previous",
    },

}
