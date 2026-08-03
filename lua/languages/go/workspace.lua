local workspace = require("utils.workspace")
local metadata = require("languages.go.metadata")

local M = {}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

---@return string|nil
function M.root()
    return vim.fs.root(0, metadata.root_markers)
end

---@return string
function M.name()
    local root = M.root()

    return root and workspace.name(root) or "default"
end

---@return string
function M.cache()
    return workspace.cache(M.name())
end

return M
