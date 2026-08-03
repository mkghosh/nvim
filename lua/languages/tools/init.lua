local M = {}

--------------------------------------------------------------------------------
-- Private
--------------------------------------------------------------------------------

---@param executable string
local function check(executable)
    if vim.fn.executable(executable) == 1 then
        vim.health.ok(executable .. " found")
    else
        vim.health.error(executable .. " not found")
    end
end

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

---Check one executable or a list of executables.
---
---@param tools? string|string[]
function M.check(tools)
    if not tools then
        return
    end

    if type(tools) == "string" then
        check(tools)
        return
    end

    for _, executable in ipairs(tools) do
        check(executable)
    end
end

---Check every tool defined in a language settings table.
---
---@param definitions table<string, string|string[]|nil>
function M.check_all(definitions)
    for _, tools in pairs(definitions) do
        M.check(tools)
    end
end

return M
