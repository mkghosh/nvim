local search = require("core.search")

return {
    ----------------------------------------------------------------------------
    -- Files
    ----------------------------------------------------------------------------

    {
        lhs = "<leader>ff",
        rhs = search.files,
        desc = "Find: Files",
    },

    {
        lhs = "<leader>fF",
        rhs = search.git_files,
        desc = "Find: Git Files",
    },

    {
        lhs = "<leader>fo",
        rhs = search.recent_files,
        desc = "Find: Recent Files",
    },

    {
        lhs = "<leader>fb",
        rhs = search.buffers,
        desc = "Find: Buffers",
    },

    ----------------------------------------------------------------------------
    -- Search
    ----------------------------------------------------------------------------

    {
        lhs = "<leader>fg",
        rhs = search.grep,
        desc = "Find: Live Grep",
    },

    {
        lhs = "<leader>fw",
        rhs = search.word,
        desc = "Find: Word",
    },

    {
        lhs = "<leader>fr",
        rhs = search.resume,
        desc = "Find: Resume",
    },

    {
        lhs = "<leader>/",
        rhs = search.current_buffer,
        desc = "Find: Current Buffer",
    },

    ----------------------------------------------------------------------------
    -- LSP
    ----------------------------------------------------------------------------

    {
        lhs = "<leader>fs",
        rhs = search.document_symbols,
        desc = "Find: Document Symbols",
    },

    {
        lhs = "<leader>fS",
        rhs = search.workspace_symbols,
        desc = "Find: Workspace Symbols",
    },

    {
        lhs = "<leader>fd",
        rhs = search.diagnostics,
        desc = "Find: Diagnostics",
    },

    ----------------------------------------------------------------------------
    -- Lists
    ----------------------------------------------------------------------------

    {
        lhs = "<leader>fq",
        rhs = search.quickfix,
        desc = "Find: Quickfix",
    },

    {
        lhs = "<leader>fl",
        rhs = search.location_list,
        desc = "Find: Location List",
    },

    ----------------------------------------------------------------------------
    -- Neovim
    ----------------------------------------------------------------------------

    {
        lhs = "<leader>fc",
        rhs = search.commands,
        desc = "Find: Commands",
    },

    {
        lhs = "<leader>fk",
        rhs = search.keymaps,
        desc = "Find: Keymaps",
    },

    {
        lhs = "<leader>fh",
        rhs = search.help,
        desc = "Find: Help",
    },

    ----------------------------------------------------------------------------
    -- Treesitter
    ----------------------------------------------------------------------------

    {
        lhs = "<leader>ft",
        rhs = search.treesitter,
        desc = "Find: Treesitter Symbols",
    },
}
