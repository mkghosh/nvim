local tab = require("core.tab")

return {

    ----------------------------------------------------------------------------
    -- Navigation
    ----------------------------------------------------------------------------

    {
        lhs = "]t",
        rhs = tab.next,
        desc = "Tab: Next",
    },

    {
        lhs = "[t",
        rhs = tab.previous,
        desc = "Tab: Previous",
    },

    ----------------------------------------------------------------------------
    -- Management
    ----------------------------------------------------------------------------

    {
        lhs = "<leader><Tab>n",
        rhs = tab.new,
        desc = "Tab: New",
    },

    {
        lhs = "<leader><Tab>c",
        rhs = tab.close,
        desc = "Tab: Close",
    },

    {
        lhs = "<leader><Tab>o",
        rhs = tab.only,
        desc = "Tab: Only",
    },

    ----------------------------------------------------------------------------
    -- Move
    ----------------------------------------------------------------------------

    {
        lhs = "<leader><Tab>h",
        rhs = tab.move_left,
        desc = "Tab: Move Left",
    },

    {
        lhs = "<leader><Tab>l",
        rhs = tab.move_right,
        desc = "Tab: Move Right",
    },

    ----------------------------------------------------------------------------
    -- Direct Access
    ----------------------------------------------------------------------------

    {
        lhs = "<leader><Tab>1",
        rhs = function() tab.goto_tab(1) end,
        desc = "Tab: 1",
    },

    {
        lhs = "<leader><Tab>2",
        rhs = function() tab.goto_tab(2) end,
        desc = "Tab: 2",
    },

    {
        lhs = "<leader><Tab>3",
        rhs = function() tab.goto_tab(3) end,
        desc = "Tab: 3",
    },

    {
        lhs = "<leader><Tab>4",
        rhs = function() tab.goto_tab(4) end,
        desc = "Tab: 4",
    },

    {
        lhs = "<leader><Tab>5",
        rhs = function() tab.goto_tab(5) end,
        desc = "Tab: 5",
    },
}
