local M = {}

--------------------------------------------------------------------------------
-- Split
--------------------------------------------------------------------------------

function M.split()
    vim.cmd.split()
end

function M.vsplit()
    vim.cmd.vsplit()
end

--------------------------------------------------------------------------------
-- Close
--------------------------------------------------------------------------------

function M.close()
    vim.cmd.close()
end

function M.only()
    vim.cmd.only()
end

--------------------------------------------------------------------------------
-- Navigation
--------------------------------------------------------------------------------

function M.left()
    vim.cmd.wincmd("h")
end

function M.down()
    vim.cmd.wincmd("j")
end

function M.up()
    vim.cmd.wincmd("k")
end

function M.right()
    vim.cmd.wincmd("l")
end

--------------------------------------------------------------------------------
-- Move Window
--------------------------------------------------------------------------------

function M.move_left()
    vim.cmd.wincmd("H")
end

function M.move_down()
    vim.cmd.wincmd("J")
end

function M.move_up()
    vim.cmd.wincmd("K")
end

function M.move_right()
    vim.cmd.wincmd("L")
end

--------------------------------------------------------------------------------
-- Resize
--------------------------------------------------------------------------------

function M.equalize()
    vim.cmd.wincmd("=")
end

function M.increase_width()
    vim.cmd("vertical resize +5")
end

function M.decrease_width()
    vim.cmd("vertical resize -5")
end

function M.increase_height()
    vim.cmd("resize +3")
end

function M.decrease_height()
    vim.cmd("resize -3")
end

--------------------------------------------------------------------------------
-- Rotation
--------------------------------------------------------------------------------

function M.rotate_down()
    vim.cmd.wincmd("r")
end

function M.rotate_up()
    vim.cmd.wincmd("R")
end

--------------------------------------------------------------------------------
-- Misc
--------------------------------------------------------------------------------

function M.next()
    vim.cmd.wincmd("w")
end

function M.previous()
    vim.cmd.wincmd("W")
end

return M
