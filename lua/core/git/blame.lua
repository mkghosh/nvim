local M = {}

local function gs()
    return require("gitsigns")
end

function M.line()
    gs().blame_line()
end

function M.toggle()
    gs().toggle_current_line_blame()
end

return M
