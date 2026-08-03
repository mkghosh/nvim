local path = require("utils.path")

local project = require("languages.java.project")

local M = {}

--------------------------------------------------------------------------------
-- Workspace
--------------------------------------------------------------------------------

---@return string
function M.root()
    return path.workspace()
end

---@return string
function M.name()
    local root = project.root()

    return root and vim.fs.basename(root) or "default"
end

---@return string
function M.project()
    local workspace = path.workspace(M.name())

    vim.fn.mkdir(workspace, "p")

    return workspace
end

--------------------------------------------------------------------------------
-- Actions
--------------------------------------------------------------------------------

function M.open()
    require("neo-tree.command").execute({
        action = "focus",
        source = "filesystem",
        dir = M.root(),
    })
end

function M.clean()
    local root = project.root()

    if not root then
        return
    end

    vim.fn.delete(M.project(), "rf")
end

return M
