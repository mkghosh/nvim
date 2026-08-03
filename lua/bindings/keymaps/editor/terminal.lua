local terminal = require("core.terminal")

return {

    ----------------------------------------------------------------------
    -- Launchers
    ----------------------------------------------------------------------

    {
        lhs = "<leader>tt",
        rhs = terminal.shell,
        desc = "Shell",
    },

    {
        lhs = "<leader>tg",
        rhs = terminal.lazygit,
        desc = "LazyGit",
    },

    {
        lhs = "<leader>th",
        rhs = terminal.htop,
        desc = "htop",
    },

    {
        lhs = "<leader>tb",
        rhs = terminal.btop,
        desc = "btop",
    },

    {
        lhs = "<leader>td",
        rhs = terminal.lazydocker,
        desc = "LazyDocker",
    },

    {
        lhs = "<leader>tk",
        rhs = terminal.k9s,
        desc = "Kubernetes",
    },

    {
        lhs = "<leader>ty",
        rhs = terminal.yazi,
        desc = "Yazi",
    },

    ----------------------------------------------------------------------
    -- Terminal Mode
    ----------------------------------------------------------------------

    {
        mode = "t",
        lhs = "<C-q>",
        rhs = [[<C-\><C-n>]],
        desc = "Terminal Normal Mode",
    },

    {
        mode = "t",
        lhs = "<C-h>",
        rhs = [[<C-\><C-n><C-w>h]],
        desc = "Window Left",
    },

    {
        mode = "t",
        lhs = "<C-j>",
        rhs = [[<C-\><C-n><C-w>j]],
        desc = "Window Down",
    },

    {
        mode = "t",
        lhs = "<C-k>",
        rhs = [[<C-\><C-n><C-w>k]],
        desc = "Window Up",
    },

    {
        mode = "t",
        lhs = "<C-l>",
        rhs = [[<C-\><C-n><C-w>l]],
        desc = "Window Right",
    },

    {
        mode = "t",
        lhs = "<C-w>w",
        rhs = [[<C-\><C-n><C-w>w]],
        desc = "Next Window",
    },

}
