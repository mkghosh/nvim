local folds = require("core.treesitter")

return {

    ----------------------------------------------------------------------
    -- Folding
    ----------------------------------------------------------------------

    {
        lhs = "<leader>zf",
        rhs = folds.toggle,
        desc = "Treesitter: Toggle Folding",
    },

    {
        lhs = "<leader>zR",
        rhs = folds.open_all,
        desc = "Treesitter: Open All Folds",
    },

    {
        lhs = "<leader>zM",
        rhs = folds.close_all,
        desc = "Treesitter: Close All Folds",
    },
}
