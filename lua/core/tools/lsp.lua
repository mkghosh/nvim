local packages = require("core.tools.packages")

local M = {}

M.ensure_installed = packages.categories.lsp

M.automatic_enable = false

return M
