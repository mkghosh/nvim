local git = require("core.git")

return {

    ----------------------------------------------------------------------
    -- Repository
    ----------------------------------------------------------------------

    {
        lhs = "<leader>gg",
        rhs = git.open,
        desc = "Git: Lazygit",
    },

    ----------------------------------------------------------------------
    -- Navigation
    ----------------------------------------------------------------------

    {
        lhs = "]h",
        rhs = git.next_hunk,
        desc = "Git: Next Hunk",
    },

    {
        lhs = "[h",
        rhs = git.prev_hunk,
        desc = "Git: Previous Hunk",
    },

    ----------------------------------------------------------------------
    -- Hunks
    ----------------------------------------------------------------------

    {
        lhs = "<leader>ga",
        rhs = git.stage_hunk,
        desc = "Git: Stage Hunk",
    },

    {
        lhs = "<leader>gr",
        rhs = git.reset_hunk,
        desc = "Git: Reset Hunk",
    },

    {
        lhs = "<leader>gp",
        rhs = git.preview_hunk,
        desc = "Git: Preview Hunk",
    },

    ----------------------------------------------------------------------
    -- Blame
    ----------------------------------------------------------------------

    {
        lhs = "<leader>gb",
        rhs = git.blame_line,
        desc = "Git: Blame Line",
    },

    {
        lhs = "<leader>gB",
        rhs = git.toggle_blame,
        desc = "Git: Toggle Inline Blame",
    },

    ----------------------------------------------------------------------
    -- Diff
    ----------------------------------------------------------------------

    {
        lhs = "<leader>gd",
        rhs = git.open_diff,
        desc = "Git: Open Diff",
    },

    {
        lhs = "<leader>gh",
        rhs = git.file_history,
        desc = "Git: File History",
    },

    {
        lhs = "<leader>gq",
        rhs = git.close_diff,
        desc = "Git: Close Diff",
    },
}
