local M = {}

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

---@param root string
---@param file string
---@return boolean
local function exists(root, file)
    return vim.uv.fs_stat(vim.fs.joinpath(root, file)) ~= nil
end

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

---@param root string
---@return string
function M.detect(root)
    if exists(root, "Makefile") or exists(root, "makefile") then
        return "make"
    end

    if exists(root, "Taskfile.yml")
        or exists(root, "Taskfile.yaml")
    then
        return "task"
    end

    if exists(root, "magefile.go") then
        return "mage"
    end

    return "go"
end

---@param system string
---@return string
function M.executable(system)
    local executables = {

        go = "go",

        make = "make",

        task = "task",

        mage = "mage",

    }

    return executables[system]
end

return M
