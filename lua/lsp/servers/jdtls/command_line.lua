local launcher =
    require("lsp.servers.jdtls.launcher")

local workspace =
    require("languages.java.workspace")

local jvm =
    require("lsp.servers.jdtls.jvm")

local runtimes =
    require("lsp.servers.jdtls.runtimes")

local M = {}

--------------------------------------------------------------------------------
-- Build JDTLS command
--------------------------------------------------------------------------------

---@param runtime? JavaRuntime
---@return string[]
function M.build(runtime)
    if not runtime then
        runtime = runtimes.jdtls()
    end

    if not runtime then
        error(
            "Unable to find a compatible JDK for JDTLS."
        )
    end

    local java =
        vim.fs.joinpath(
            runtime.path,
            "bin",
            "java"
        )

    local cmd = {
        java,
    }

    vim.list_extend(cmd, jvm)

    vim.list_extend(cmd, {
        "-jar",
        launcher.jar(),

        "-configuration",
        launcher.config(),

        "-data",
        workspace.project(),
    })

    return cmd
end

return M
