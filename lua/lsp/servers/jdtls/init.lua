---@diagnostic disable: undefined-field

local jdtls = require("jdtls")

local bundles = require("lsp.servers.jdtls.bundles")

local command_line = require("lsp.servers.jdtls.command_line")

local dap = require("lsp.servers.jdtls.dap")

local settings = require("lsp.servers.jdtls.settings")

local runtimes = require("lsp.servers.jdtls.runtimes")

local metadata = require("languages.java.metadata")

local project = require("languages.java.project")

local spring = require("languages.java.spring")

local java_dap = require("languages.java.dap")

local M = {}

--------------------------------------------------------------------------------
-- Metadata
--------------------------------------------------------------------------------

M.filetypes = metadata.filetypes

M.root_markers = metadata.root_markers

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

function M.setup()
    local root = project.root()

    if not root then
        return
    end

    --------------------------------------------------------------------------
    -- Select JDTLS JVM
    --------------------------------------------------------------------------

    local jdtls_runtime, jdtls_error =
        runtimes.jdtls()

    if not jdtls_runtime then
        vim.notify(
            jdtls_error
            or "Unable to find a compatible JDK for JDTLS.",
            vim.log.levels.ERROR
        )

        return
    end

    --------------------------------------------------------------------------
    -- Resolve project runtime
    --
    -- This is independent from the JDTLS runtime.
    --------------------------------------------------------------------------

    local project_runtime, project_runtime_error =
        project.java_runtime()

    if not project_runtime then
        vim.notify(
            project_runtime_error
            or "Project Java runtime could not be resolved.",
            vim.log.levels.WARN
        )
    end

    --------------------------------------------------------------------------
    -- Java tooling
    --------------------------------------------------------------------------

    dap.setup()
    java_dap.setup()
    spring.setup()

    --------------------------------------------------------------------------
    -- Start JDTLS
    --------------------------------------------------------------------------

    jdtls.start_or_attach({

        cmd =
            command_line.build(jdtls_runtime),

        root_dir = root,

        capabilities =
            require("lsp.capabilities").get(),

        settings =
            settings.build(),

        init_options = {
            bundles = bundles.find(),
        },

    })

    --------------------------------------------------------------------------
    -- Runtime information
    --------------------------------------------------------------------------

    local jdtls_version =
        tonumber(
            jdtls_runtime.name:match(
                "JavaSE%-(%d+)"
            )
        )

    if project_runtime then
        local project_version =
            tonumber(
                project_runtime.name:match(
                    "JavaSE%-(%d+)"
                )
            )

        vim.notify(
            string.format(
                "Java project: %s | Project JDK: %d | JDTLS JDK: %d",
                vim.fn.fnamemodify(root, ":t"),
                project_version,
                jdtls_version
            ),
            vim.log.levels.INFO
        )
    else
        vim.notify(
            string.format(
                "Java project: %s | Project JDK: unavailable | JDTLS JDK: %d",
                vim.fn.fnamemodify(root, ":t"),
                jdtls_version
            ),
            vim.log.levels.WARN
        )
    end
end

return M
