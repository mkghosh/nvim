local packages = require("core.tools.packages")

local M = {}

--------------------------------------------------------------------------------
-- Private
--------------------------------------------------------------------------------

---@param categories table<string, string[]>
---@return string[]
local function flatten(categories)
    local result = {}

    for _, category in pairs(categories) do
        vim.list_extend(result, category)
    end

    return result
end

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

M.ensure_installed = flatten(packages.categories)

M.run_on_start = true

M.auto_update = false

M.start_delay = 3000

M.debounce_hours = 24

return M
