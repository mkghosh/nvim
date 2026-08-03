local autocmds = {}

local modules = {
    "java",
}

for _, module in ipairs(modules) do
    vim.list_extend(
        autocmds,
        require("bindings.autocmds.languages." .. module)
    )
end

return autocmds
