local path = require("core.utils.path")

local M = {}

local mason = path.mason("packages")

local function glob(pattern)
    return vim.split(
        vim.fn.glob(pattern),
        "\n",
        { trimempty = true }
    )
end

function M.find()
    local bundles = {}

    vim.list_extend(
        bundles,
        glob(mason .. "/java-debug-adapter/extension/server/*.jar")
    )

    vim.list_extend(
        bundles,
        glob(mason .. "/java-test/extension/server/*.jar")
    )

    return bundles
end

return M
