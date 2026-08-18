local actions = require("languages.java.actions")
local refactor = require("lsp.servers.jdtls.refactor")
local test = require("lsp.servers.jdtls.test")
local workspace = require("languages.java.workspace")

local commands = {

    --------------------------------------------------------------------------
    -- Project
    --------------------------------------------------------------------------

    {
        name = "JavaBuild",
        callback = actions.build,
        desc = "Build Java Project",
    },

    {
        name = "JavaClean",
        callback = actions.clean,
        desc = "Clean Java Project",
    },

    {
        name = "JavaInstall",
        callback = actions.install,
        desc = "Install Java Project",
    },

    {
        name = "JavaDeploy",
        callback = actions.deploy,
        desc = "Deploy Java Project",
    },

    {
        name = "JavaTest",
        callback = actions.test,
        desc = "Run Project Tests",
    },

    {
        name = "JavaHealth",
        callback = actions.health,
        desc = "Check Java Toolchain",
    },

    {
        name = "JdtUpdate",
        callback = "JdtUpdateConfig",
        desc = "Update JDTLS project configuration",
    },



    --------------------------------------------------------------------------
    -- Refactoring
    --------------------------------------------------------------------------

    {
        name = "JavaOrganizeImports",
        callback = refactor.organize_imports,
        desc = "Organize Imports",
    },

    --------------------------------------------------------------------------
    -- Tests
    --------------------------------------------------------------------------

    {
        name = "JavaTestClass",
        callback = test.class,
        desc = "Run Current Test Class",
    },

    {
        name = "JavaTestNearest",
        callback = test.nearest,
        desc = "Run Nearest Test",
    },

    {
        name = "JavaTestPick",
        callback = test.pick,
        desc = "Pick Test",
    },

    --------------------------------------------------------------------------
    -- Workspace
    --------------------------------------------------------------------------

    {
        name = "JavaWorkspace",
        callback = workspace.open,
        desc = "Open Workspace",
    },

    {
        name = "JavaWorkspaceClean",
        callback = workspace.clean,
        desc = "Clean Workspace",
    },

}

--------------------------------------------------------------------------------
-- Spring
--------------------------------------------------------------------------------

if require("languages.java.spring.project").exists() then
    vim.list_extend(
        commands,
        require("bindings.commands.languages.java.spring")
    )
end

return commands
