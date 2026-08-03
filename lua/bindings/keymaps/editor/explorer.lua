local explorer = require("core.explorer")

return {
    ----------------------------------------------------------------------------
    -- Explorer
    ----------------------------------------------------------------------------

    {
        lhs = "<leader>ee",
        rhs = explorer.toggle,
        desc = "Explorer: Toggle",
    },

    {
        lhs = "<leader>ef",
        rhs = explorer.reveal,
        desc = "Explorer: Reveal",
    },

    {
        lhs = "<leader>eo",
        rhs = explorer.open,
        desc = "Explorer: Open Directory",
    },

    {
        lhs = "<leader>eb",
        rhs = explorer.buffers,
        desc = "Explorer: Buffers",
    },

    {
        lhs = "<leader>eg",
        rhs = explorer.git,
        desc = "Explorer: Git",
    },

    {
        lhs = "<leader>eF",
        rhs = explorer.focus,
        desc = "Explorer: Focus",
    },
}
