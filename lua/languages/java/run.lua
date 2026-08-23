---@diagnostic disable: undefined-field

local jdtls = require("jdtls")

local M = {}

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

local function client()
    local clients =
        vim.lsp.get_clients({
            bufnr = 0,
            name = "jdtls",
        })

    return clients[1]
end

--------------------------------------------------------------------------------
-- Run
--------------------------------------------------------------------------------

function M.run()
    local c = client()

    if not c then
        vim.notify(
            "JDTLS is not attached to this buffer.",
            vim.log.levels.ERROR
        )
        return
    end

    jdtls.test_class()
end

return M
