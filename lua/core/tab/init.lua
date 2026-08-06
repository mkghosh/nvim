local M = {}

--------------------------------------------------------------------------------
-- Navigation
--------------------------------------------------------------------------------

function M.next()
    vim.cmd.tabnext()
end

function M.previous()
    vim.cmd.tabprevious()
end

--------------------------------------------------------------------------------
-- Management
--------------------------------------------------------------------------------

function M.new()
    vim.cmd.tabnew()
end

function M.close()
    vim.cmd.tabclose()
end

function M.only()
    vim.cmd.tabonly()
end

--------------------------------------------------------------------------------
-- Movement
--------------------------------------------------------------------------------

function M.move_left()
    vim.cmd("-tabmove")
end

function M.move_right()
    vim.cmd("+tabmove")
end

--------------------------------------------------------------------------------
-- Selection
--------------------------------------------------------------------------------

---@param index integer
function M.goto_tab(index)
    vim.cmd(index .. "tabnext")
end

return M
