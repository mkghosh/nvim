local border = require("utils.border")
local icons = require("utils.icons")

local M = {}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

function M.setup()
    vim.diagnostic.config({

        virtual_text = {
            spacing = 2,
            source = "if_many",
        },

        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
                [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
                [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
            },
        },

        underline = true,

        severity_sort = true,

        update_in_insert = false,

        float = {
            border = border,
            source = "if_many",
        },
    })
end

return M
