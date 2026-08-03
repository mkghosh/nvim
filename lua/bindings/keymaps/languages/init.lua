local keymap = require("utils.keymap")
local languages = require("languages")

local M = {}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

---@param filetype string
---@param bufnr integer
function M.attach(filetype, bufnr)
    local language = languages.resolve(filetype)

    if not language then
        return
    end

    local ok, mappings = pcall(
        require,
        "bindings.keymaps.languages." .. language
    )

    if not ok then
        return
    end

    keymap.set_buffer(bufnr, mappings)
end

return M
