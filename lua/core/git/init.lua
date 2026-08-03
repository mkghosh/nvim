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

M.status = repo.status
M.commit = repo.commit
M.push = repo.push
M.pull = repo.pull
M.fetch = repo.fetch
M.log = repo.log
M.branch = repo.branch

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
