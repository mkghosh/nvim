local runtime_manager = require("lsp.servers.jdtls.runtimes")

local M = {}

function M.build()
    return {

        java = {

            eclipse = {
                downloadSources = true,
            },

            configuration = {

                updateBuildConfiguration = "interactive",

                runtimes = runtime_manager.get(),

            },

            maven = {
                downloadSources = true,
            },

            implementationsCodeLens = {
                enabled = true,
            },

            referencesCodeLens = {
                enabled = true,
            },

            references = {
                includeDecompiledSources = true,
            },

            signatureHelp = {
                enabled = true,
            },

            format = {
                enabled = true,
            },

            contentProvider = {
                preferred = "fernflower",
            },

            saveActions = {
                organizeImports = true,
            },

            completion = {

                favoriteStaticMembers = {

                    "org.assertj.core.api.Assertions.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "org.junit.jupiter.api.Assumptions.*",
                    "org.junit.jupiter.api.DynamicContainer.*",
                    "org.junit.jupiter.api.DynamicTest.*",
                    "org.mockito.Mockito.*",

                },

            },

            sources = {

                organizeImports = {

                    starThreshold = 9999,

                    staticStarThreshold = 9999,

                },

            },

        },

    }
end

return M
