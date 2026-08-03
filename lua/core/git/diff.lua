local M = {}

function M.open()
    vim.cmd("DiffviewOpen")
end

function M.close()
    vim.cmd("DiffviewClose")
end

function M.history()
    vim.cmd("DiffviewFileHistory")
end

return M
