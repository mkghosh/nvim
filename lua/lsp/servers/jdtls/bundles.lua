local path = require("utils.path")

local M = {}

local mason = path.mason("packages")

local java_test_server =
    vim.fn.expand(
        "~/.local/share/nvim/java-test-0.46.0/extension/server"
    )

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
    --
    -- Upstream vscode-java-test 0.46.0
    --
    -- IMPORTANT:
    -- Do not use Mason's java-test package here.
    --
    -- Mason currently installs the 0.45.0 registry entry but the package
    -- contains the older 0.43.1 server/JAR dependency set.
    --
    -- Upstream 0.46.0 ships:
    --   ASM       9.10.1
    --   ASM Tree  9.10.1
    --   ASM Commons 9.10.1
    --   JaCoCo    0.8.15
    --------------------------------------------------------------------------

    local java_test_jars = {
        "com.microsoft.java.test.plugin-0.43.1.jar",

        "junit-jupiter-api_5.14.4.jar",
        "junit-jupiter-api_6.0.1.jar",

        "junit-jupiter-engine_5.14.4.jar",
        "junit-jupiter-engine_6.0.1.jar",

        "junit-jupiter-migrationsupport_5.14.4.jar",

        "junit-jupiter-params_5.14.4.jar",
        "junit-jupiter-params_6.0.1.jar",

        "junit-platform-commons_1.14.4.jar",
        "junit-platform-commons_6.0.1.jar",

        "junit-platform-engine_1.14.4.jar",
        "junit-platform-engine_6.0.1.jar",

        "junit-platform-launcher_1.14.4.jar",
        "junit-platform-launcher_6.0.1.jar",

        "junit-platform-runner_1.14.4.jar",

        "junit-platform-suite-api_1.14.4.jar",
        "junit-platform-suite-api_6.0.1.jar",

        "junit-platform-suite-commons_1.14.4.jar",

        "junit-platform-suite-engine_1.14.4.jar",
        "junit-platform-suite-engine_6.0.1.jar",

        "junit-vintage-engine_5.14.4.jar",

        "org.apiguardian.api_1.1.2.jar",

        "org.eclipse.jdt.junit4.runtime_1.4.0.v20251113-1434.jar",
        "org.eclipse.jdt.junit5.runtime_1.2.0.v20251113-1434.jar",
        "org.eclipse.jdt.junit6.runtime_1.0.0.v20251112-1701.jar",

        "org.jacoco.core_0.8.15.202606040825.jar",

        "org.objectweb.asm.commons_9.10.1.jar",
        "org.objectweb.asm.tree_9.10.1.jar",
        "org.objectweb.asm_9.10.1.jar",

        "org.opentest4j_1.3.0.jar",
    }

    for _, name in ipairs(java_test_jars) do
        local jar = vim.fs.joinpath(
            java_test_server,
            name
        )

        if vim.fn.filereadable(jar) == 1 then
            table.insert(bundles, jar)
        else
            vim.notify(
                "Java Test bundle missing: " .. jar,
                vim.log.levels.WARN
            )
        end
    end

    return bundles
end

return M
