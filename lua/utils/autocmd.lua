local M = {}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

---Create (or reuse) an autocmd group.
---
---@param name string
---@param opts? AutocmdGroupOptions
---@return integer group_id
function M.group(name, opts)
    opts = opts or {}

    return vim.api.nvim_create_augroup(name, {
        clear = opts.clear ~= false,
    })
end

---Create a single autocmd.
---
---@param event string|string[]
---@param definition AutocmdOptions
function M.create(event, definition)
    local group = definition.group

    if type(group) == "string" then
        group = M.group(group)
    end

    local opts = vim.tbl_extend("force", {}, definition)

    opts.group = group

    vim.api.nvim_create_autocmd(event, opts)
end

---Create multiple autocmds.
---
---@param definitions AutocmdDefinition[]
function M.create_all(definitions)
    for _, definition in ipairs(definitions) do
        local opts = vim.tbl_extend("force", {}, definition)

        opts.event = nil

        M.create(definition.event, opts)
    end
end

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

---Load an autocmd module and register all definitions.
---
---@param module string
function M.module(module)
    M.create_all(require(module))
end

return M
