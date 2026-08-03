return {
    {
        "stevearc/oil.nvim",

        cmd = "Oil",

        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },

        opts = {
            default_file_explorer = true,

            delete_to_trash = true,

            skip_confirm_for_simple_edits = true,

            view_options = {
                show_hidden = true,
            },
        },
    },
}
