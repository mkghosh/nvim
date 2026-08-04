local path = require("utils.path")

local project = require("languages.python.project")

local M = {}

--------------------------------------------------------------------------------
-- Workspace
--------------------------------------------------------------------------------

function M.root()
    return project.root()
end

function M.name()
    local root = M.root()

    return root and vim.fs.basename(root) or "default"
end

function M.cache()
    return path.workspace(M.name())
end

return M
