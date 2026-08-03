local M = {}

--------------------------------------------------------------------------------
-- gopls
--------------------------------------------------------------------------------

M.gopls = {

    analyses = {

        unusedparams = true,

        shadow = true,
    },

    staticcheck = true,

    gofumpt = true,
}

return M
