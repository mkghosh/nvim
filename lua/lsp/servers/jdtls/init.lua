---@diagnostic disable: undefined-field

local jdtls = require("jdtls")

local bundles = require("lsp.servers.jdtls.bundles")
local command_line = require("lsp.servers.jdtls.command_line")
local dap = require("lsp.servers.jdtls.dap")
local settings = require("lsp.servers.jdtls.settings")

local metadata = require("languages.java.metadata")
local project = require("languages.java.project")
local spring = require("languages.java.spring")

local M = {}

--------------------------------------------------------------------------------
-- Metadata
--------------------------------------------------------------------------------

M.filetypes = metadata.filetypes
M.root_markers = metadata.root_markers

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

function M.setup()
    local root = project.root()

    if not root then
        return
    end

    --------------------------------------------------------------------------
    -- Java Runtime
    --------------------------------------------------------------------------

    dap.setup()

    spring.setup()

    --------------------------------------------------------------------------
    -- JDTLS
    --------------------------------------------------------------------------

    jdtls.start_or_attach({
        cmd = command_line.build(),

        root_dir = root,

        capabilities = require("lsp.capabilities").get(),

        settings = settings.build(),

        init_options = {
            bundles = bundles.find(),
        },
    })
end

return M
