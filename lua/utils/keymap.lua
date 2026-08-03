local M = {}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param desc? string
---@param opts? vim.keymap.set.Opts
function M.set(mode, lhs, rhs, desc, opts)
    opts = vim.tbl_extend("force", {}, opts or {})

    opts.silent = opts.silent ~= false
    opts.noremap = opts.noremap ~= false
    opts.desc = desc

    vim.keymap.set(mode, lhs, rhs, opts)

    return {
        mode = mode,
        lhs = lhs,
        rhs = rhs,
        desc = desc,
        opts = opts,
    }
end

---@param mappings KeymapDefinition[]
function M.set_all(mappings)
    for _, mapping in ipairs(mappings) do
        M.set(
            mapping.mode or "n",
            mapping.lhs,
            mapping.rhs,
            mapping.desc,
            mapping.opts
        )
    end
end

---@param bufnr integer
---@param mappings KeymapDefinition[]
function M.set_buffer(bufnr, mappings)
    for _, mapping in ipairs(mappings) do
        M.set(
            mapping.mode or "n",
            mapping.lhs,
            mapping.rhs,
            mapping.desc,
            vim.tbl_extend("force", mapping.opts or {}, {
                buffer = bufnr,
            })
        )
    end
end

--------------------------------------------------------------------------------
-- Lazy.nvim
--------------------------------------------------------------------------------

---@param mappings KeymapDefinition[]
---@return LazyKeyDefinition[]
function M.lazy(mappings)
    local keys = {}

    for _, mapping in ipairs(mappings) do
        local key = vim.tbl_extend("force", {}, mapping.opts or {})

        key[1] = mapping.lhs
        key[2] = mapping.rhs
        key.mode = mapping.mode
        key.desc = mapping.desc

        table.insert(keys, key)
    end

    return keys
end

---@param module string
---@return LazyKeyDefinition[]
function M.module(module)
    return M.lazy(require(module))
end

return M
