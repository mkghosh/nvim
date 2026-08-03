local M = {}

M.keymap = {
    ["<CR>"] = { "accept", "fallback" },

    ["<C-Space>"] = {
        "show",
        "show_documentation",
        "hide_documentation",
    },

    ["<C-n>"] = { "select_next", "fallback" },

    ["<C-p>"] = { "select_prev", "fallback" },
}

function M.setup()
    -- Reserved for future editor-level completion mappings.
end

return M
