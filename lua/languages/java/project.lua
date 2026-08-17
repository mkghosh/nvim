local metadata = require("languages.java.metadata")

local M = {}

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

local uv = vim.uv

---@param path string
---@return boolean
local function exists(path)
    return uv.fs_stat(path) ~= nil
end

--------------------------------------------------------------------------------
-- Project
--------------------------------------------------------------------------------

---@return string?
function M.root()
    return vim.fs.root(0, metadata.root_markers)
end

---@return boolean
function M.is_maven()
    local root = M.root()

    return root ~= nil
        and exists(vim.fs.joinpath(root, "pom.xml"))
end

---@return boolean
function M.is_gradle()
    local root = M.root()

    return root ~= nil
        and (
            exists(vim.fs.joinpath(root, "build.gradle"))
            or exists(vim.fs.joinpath(root, "build.gradle.kts"))
        )
end

--------------------------------------------------------------------------------
-- Build System
--------------------------------------------------------------------------------

---@return JavaBuildSystem?
function M.system()
    if M.is_maven() then
        return "maven"
    end

    if M.is_gradle() then
        return "gradle"
    end

    return nil
end

---@return string?
function M.executable()
    local root = M.root()

    if not root then
        return nil
    end

    local system = M.system()

    if not system then
        return nil
    end

    local build = metadata.build[system]
    if build.prefer_wrapper then
        local wrapper = vim.fs.joinpath(root, build.wrapper)

        if exists(wrapper) then
            return "./" .. build.wrapper
        end
    end

    return build.executable
end

--------------------------------------------------------------------------------
-- Toolchain
--------------------------------------------------------------------------------

---@return JavaToolchain?
function M.toolchain()
    local system = M.system()

    if not system then
        return nil
    end

    local executable = M.executable()

    if not executable then
        return nil
    end

    return {
        system = system,
        executable = executable,
    }
end

--------------------------------------------------------------------------------
-- Tasks
--------------------------------------------------------------------------------

---@param task TaskDefinition
---@return TaskDefinition?
function M.task(task)
    local toolchain = M.toolchain()

    if not toolchain then
        return nil
    end

    local arguments = task[toolchain.system]

    if not arguments then
        return nil
    end

    return {
        title = task.title,
        executable = toolchain.executable,
        system = toolchain.system,
        [toolchain.system] = arguments,
    }
end

return M
