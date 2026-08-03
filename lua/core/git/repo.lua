local M = {}

function M.status()
    vim.cmd("Git")
end

function M.commit()
    vim.cmd("Git commit")
end

function M.push()
    vim.cmd("Git push")
end

function M.pull()
    vim.cmd("Git pull --rebase")
end

function M.fetch()
    vim.cmd("Git fetch")
end

function M.log()
    vim.cmd("Git log")
end

function M.branch()
    vim.cmd("Git branch")
end

return M
