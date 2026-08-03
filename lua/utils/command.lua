local M = {}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

---Create a user command.
---
---@param definition CommandDefinition
function M.create(definition)
    local opts = vim.tbl_extend("force", {}, definition.opts or {})

    opts.desc = definition.desc

    vim.api.nvim_create_user_command(
        definition.name,
        definition.callback,
        opts
    )
end

---Create multiple user commands.
---
---@param definitions CommandDefinition[]
function M.create_all(definitions)
    for _, definition in ipairs(definitions) do
        M.create(definition)
    end
end

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

---Load a command module and register all commands.
---
---@param module string
function M.module(module)
    M.create_all(require(module))
end

return M
