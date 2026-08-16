local path = require("utils.path")

local M = {}

local mason = path.mason("packages")

local function glob(pattern)
    return vim.split(
        vim.fn.glob(pattern),
        "\n",
        { trimempty = true }
    )
end

--------------------------------------------------------------------------------
-- Bundles
--------------------------------------------------------------------------------

function M.find()
    local bundles = {}

    --------------------------------------------------------------------------
    -- Java Debug Adapter
    --------------------------------------------------------------------------

    vim.list_extend(
        bundles,
        glob(
            mason
            .. "/java-debug-adapter/extension/server/*.jar"
        )
    )

    return bundles
end

return M
