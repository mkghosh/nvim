local server = require("lsp.server")

local metadata = require("languages.python.metadata")
local config = vim.deepcopy(require("languages.python.config"))
--local project = require("languages.python.project")

--------------------------------------------------------------------------------
-- Project Configuration
--------------------------------------------------------------------------------

-- config.basedpyright.python = {
--     pythonPath = project.python(),
-- }
--
--------------------------------------------------------------------------------
-- Server
--------------------------------------------------------------------------------

return server.create({

    filetypes = metadata.filetypes,

    root_markers = metadata.root_markers,

    settings = {

        basedpyright = config.basedpyright,

    },

})
