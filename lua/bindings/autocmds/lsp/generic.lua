local editor = require("bindings.keymaps.editor.lsp")
local languages = require("bindings.keymaps.languages")

return {
    {
        event = "LspAttach",

        group = "UserLspBindings",

        callback = function(args)
            local bufnr = args.buf
            local filetype = vim.bo[bufnr].filetype

            editor.attach(bufnr)
            languages.attach(filetype, bufnr)
        end,

        desc = "Attach LSP keymaps",
    },
}
