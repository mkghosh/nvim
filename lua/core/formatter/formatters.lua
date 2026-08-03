local M = {}

local prettier = { "prettier" }

M.by_ft = {
    json = prettier,
    yaml = prettier,
    markdown = prettier,
    html = prettier,
    css = prettier,
    javascript = prettier,
    javascriptreact = prettier,
    typescript = prettier,
    typescriptreact = prettier,
}

return M
