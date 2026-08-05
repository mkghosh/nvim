local project = require("languages.python.project")

local M = {}

--------------------------------------------------------------------------------
-- BasedPyright
--------------------------------------------------------------------------------

M.basedpyright = {

    analysis = {

        typeCheckingMode = "recommended",

        autoSearchPaths = true,

        useLibraryCodeForTypes = true,

        diagnosticMode = "workspace",

    },

    python = {

        pythonPath = project.python(),

    },

}

--------------------------------------------------------------------------------
-- Ruff
--------------------------------------------------------------------------------

M.ruff = {}

return M
