local path = require("utils.path")

local M = {}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

---@param project_root string
---@return string
function M.project(project_root)
    return path.workspace(vim.fs.basename(project_root))
end

---@param project_root string
---@return string
function M.name(project_root)
    return vim.fs.basename(project_root)
end

---@param project_name string
---@return string
function M.cache(project_name)
    return path.workspace(project_name)
end

return M
