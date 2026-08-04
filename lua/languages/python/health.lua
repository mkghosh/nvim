local M = {}

local function executable(name)
    if vim.fn.executable(name) == 1 then
        vim.health.ok(name .. " found")
    else
        vim.health.error(name .. " not found")
    end
end

function M.check()
    vim.health.start("Python")

    executable("python")

    executable("basedpyright-langserver")

    executable("ruff")

    executable("debugpy")

    executable("pytest")

    executable("jupyter")
end

return M
