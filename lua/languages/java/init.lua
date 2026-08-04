local M = {}

function M.setup()
    require("lsp.servers.jdtls").setup()
end

return M
