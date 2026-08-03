local navigation = require("core.navigation")

return {
    ----------------------------------------------------------------------------
    -- Harpoon
    ----------------------------------------------------------------------------

    {
        lhs = "<leader>ha",
        rhs = navigation.add_file,
        desc = "Navigation: Add Bookmark",
    },

    {
        lhs = "<leader>hh",
        rhs = navigation.show,
        desc = "Navigation: Show Bookmarks",
    },

    {
        lhs = "<leader>h1",
        rhs = function()
            navigation.select(1)
        end,
        desc = "Navigation: Bookmark 1",
    },

    {
        lhs = "<leader>h2",
        rhs = function()
            navigation.select(2)
        end,
        desc = "Navigation: Bookmark 2",
    },

    {
        lhs = "<leader>h3",
        rhs = function()
            navigation.select(3)
        end,
        desc = "Navigation: Bookmark 3",
    },

    {
        lhs = "<leader>h4",
        rhs = function()
            navigation.select(4)
        end,
        desc = "Navigation: Bookmark 4",
    },
}
