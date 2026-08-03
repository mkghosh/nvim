local M = {}

local function harpoon()
    return require("harpoon")
end

local function ui()
    return require("harpoon.ui")
end

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

function M.add_file()
    harpoon():list():add()
end

function M.show()
    ui():toggle_quick_menu(harpoon():list())
end

---@param index integer
function M.select(index)
    harpoon():list():select(index)
end

return M
