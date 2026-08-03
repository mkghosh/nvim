local server = require("lsp.server")

local config = require("languages.go.config")
local metadata = require("languages.go.metadata")

return server.create({

    filetypes = metadata.filetypes,

    root_markers = metadata.root_markers,

    settings = {
        gopls = config.gopls,
    },

})
