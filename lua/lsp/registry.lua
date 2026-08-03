local M = {}

--------------------------------------------------------------------------------
-- Private
--------------------------------------------------------------------------------

M.servers = {

    "lua_ls",

    "bashls",

    "jsonls",
    "yamlls",

    "gopls",

    "dockerls",

}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

function M.register()
    for _, server in ipairs(M.servers) do
        vim.lsp.config(
            server,
            require("lsp.servers." .. server)
        )
    end
end

function M.enable()
    vim.lsp.enable(M.servers)
end

return M
