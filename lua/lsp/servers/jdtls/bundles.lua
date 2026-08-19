local path = require("utils.path")

local M = {}

local mason = path.mason("packages")

local function glob(pattern)
    return vim.fn.glob(pattern, false, true)
end

function M.find()
    local bundles = {}

    --------------------------------------------------------------------------
    -- Java Debug Adapter
    --------------------------------------------------------------------------

    vim.list_extend(
        bundles,
        glob(
            mason
            .. "/java-debug-adapter/extension/server/"
            .. "com.microsoft.java.debug.plugin-*.jar"
        )
    )

    --------------------------------------------------------------------------
    -- Java Test
    --------------------------------------------------------------------------

    for _, jar in ipairs(
        glob(mason .. "/java-test/extension/server/*.jar")
    ) do
        local name = vim.fn.fnamemodify(jar, ":t")

        if name ~= "com.microsoft.java.test.runner-jar-with-dependencies.jar"
            and name ~= "jacocoagent.jar"
        then
            table.insert(bundles, jar)
        end
    end

    return bundles
end

return M
