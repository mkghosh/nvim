---@diagnostic disable: undefined-field

local M = {}

local initialized = false

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

function M.setup()
    if initialized then
        return
    end

    initialized = true

    require("lua.lsp.servers.jdtls.jdtls").setup_dap({
        hotcodereplace = "auto",
    })
end

return M
