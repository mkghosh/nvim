local autocmds = {

    {
        event = {
            "BufReadPost",
            "BufNewFile",
        },

        pattern = "*.java",

        callback = function()
            require("lsp.servers.jdtls").setup()
        end,

        desc = "Start JDTLS",
    },

}

if require("languages.java.spring.project").exists() then
    vim.list_extend(
        autocmds,
        require("bindings.autocmds.languages.java.spring")
    )
end

return autocmds
