local M = {}

----------------------------------------------------------------------
-- Standard Paths
----------------------------------------------------------------------

M.data = vim.fn.stdpath("data")
M.cache = vim.fn.stdpath("cache")
M.state = vim.fn.stdpath("state")
M.config = vim.fn.stdpath("config")

----------------------------------------------------------------------
-- Helpers
----------------------------------------------------------------------

---@param ... string
---@return string
function M.join(...)
    return vim.fs.joinpath(...)
end

---@param ... string
---@return string
function M.data_path(...)
    return M.join(M.data, ...)
end

---@param ... string
---@return string
function M.cache_path(...)
    return M.join(M.cache, ...)
end

---@param ... string
---@return string
function M.state_path(...)
    return M.join(M.state, ...)
end

---@param ... string
---@return string
function M.config_path(...)
    return M.join(M.config, ...)
end

----------------------------------------------------------------------
-- Common Locations
----------------------------------------------------------------------

---@param name? string
---@return string
function M.workspace(name)
    return M.data_path("workspaces", name)
end

---@param ... string
---@return string
function M.mason(...)
    return M.data_path("mason", ...)
end

return M
