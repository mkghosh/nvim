local autocmds = {}

if require("languages.java.spring.project").exists() then
    vim.list_extend(
        autocmds,
        require("bindings.autocmds.languages.java.spring")
    )
end

return autocmds
