local autocmds = {}

vim.list_extend(
    autocmds,
    require("bindings.autocmds.lsp.generic")
)

vim.list_extend(
    autocmds,
    require("bindings.autocmds.lsp.jdtls")
)

return autocmds
