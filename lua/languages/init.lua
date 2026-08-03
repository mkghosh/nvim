local M = {}

--------------------------------------------------------------------------------
-- Filetype → Language
--------------------------------------------------------------------------------

local mapping = {
    -- Go
    go = "go",
    gomod = "go",
    gowork = "go",
    gotmpl = "go",

    -- Java
    java = "java",

    -- Lua
    lua = "lua",

    -- Shell
    sh = "bash",
    bash = "bash",

    -- JSON
    json = "json",

    -- YAML
    yaml = "yaml",

    -- Markdown
    markdown = "markdown",
}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

---@param filetype string
---@return string?
function M.resolve(filetype)
    return mapping[filetype]
end

return M
