require("config.options")
require("config.keymaps")
require("config.lazy")
require("config.autocmds")

require("lsp").setup()

require("core.debugger").setup()

require("bindings").setup()
