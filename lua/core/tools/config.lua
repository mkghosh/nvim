local border = require("utils.border")

local M = {}

M.PATH = "prepend"

M.ui = {
    border = border,

    icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
    },
}

return M
