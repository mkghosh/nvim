local server = require("lsp.server")

local config = require("languages.python.config")
local metadata = require("languages.python.metadata")

return server.create({

    filetypes = metadata.filetypes,

    root_markers = metadata.root_markers,

    settings = {

        basedpyright = config.basedpyright,

    },

})
