local M = {}

local repo = require("core.git.repo")
local hunks = require("core.git.hunks")
local blame = require("core.git.blame")
local diff = require("core.git.diff")

function M.setup()
end

----------------------------------------------------------------------
-- Repository
----------------------------------------------------------------------

M.open = repo.open

----------------------------------------------------------------------
-- Navigation
----------------------------------------------------------------------

M.next_hunk = hunks.next_hunk
M.prev_hunk = hunks.prev_hunk

----------------------------------------------------------------------
-- Hunks
----------------------------------------------------------------------

M.stage_hunk = hunks.stage
M.reset_hunk = hunks.reset
M.preview_hunk = hunks.preview

----------------------------------------------------------------------
-- Blame
----------------------------------------------------------------------

M.blame_line = blame.line
M.toggle_blame = blame.toggle

----------------------------------------------------------------------
-- Diff
----------------------------------------------------------------------

M.open_diff = diff.open
M.file_history = diff.history
M.close_diff = diff.close

return M
