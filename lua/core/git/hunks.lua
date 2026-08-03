local M = {}

local function gs()
    return require("gitsigns")
end

function M.next_hunk()
    gs().nav_hunk("next")
end

function M.prev_hunk()
    gs().nav_hunk("prev")
end

function M.stage()
    gs().stage_hunk()
end

function M.reset()
    gs().reset_hunk()
end

function M.preview()
    gs().preview_hunk()
end

return M
