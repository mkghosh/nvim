local M = {}

M.by_ft = {

    lua = {
        "luacheck",
    },

    sh = {
        "shellcheck",
    },

    bash = {
        "shellcheck",
    },

    python = {
        "ruff",
    },

    yaml = {
        "yamllint",
    },

    markdown = {},

    json = {},

    java = {},

    go = {},
}

return M
