local map = require("utils.keymap").set

local actions = require("languages.java.actions")
local workspace = require("languages.java.workspace")

local refactor = require("lsp.servers.jdtls.refactor")
local test = require("lsp.servers.jdtls.test")

local spring = require("languages.java.spring.project")

local mappings = {

    ----------------------------------------------------------------------------
    -- Workspace
    ----------------------------------------------------------------------------

    map(
        "n",
        "<leader>jcw",
        workspace.open,
        "Open Workspace"
    ),

    map(
        "n",
        "<leader>jcc",
        workspace.clean,
        "Clean Workspace"
    ),

    ----------------------------------------------------------------------------
    -- Project
    ----------------------------------------------------------------------------

    map(
        "n",
        "<leader>jpb",
        actions.build,
        "Build Project"
    ),

    map(
        "n",
        "<leader>jpc",
        actions.clean,
        "Clean Project"
    ),

    map(
        "n",
        "<leader>jpi",
        actions.install,
        "Install Project"
    ),

    map(
        "n",
        "<leader>jpd",
        actions.deploy,
        "Deploy Project"
    ),

    map(
        "n",
        "<leader>jpt",
        actions.test,
        "Run Tests"
    ),

    map(
        "n",
        "<leader>jh",
        actions.health,
        "Health Check"
    ),

    ----------------------------------------------------------------------------
    -- Refactoring
    ----------------------------------------------------------------------------

    map(
        "n",
        "<leader>ji",
        refactor.organize_imports,
        "Organize Imports"
    ),
    map(
        "n",
        "<leader>jmf",
        refactor.move_file,
        "Java Move File"
    ),

    map(
        "n",
        "<leader>jmp",
        refactor.move_package,
        "Java Rename/Move Package"
    ),

    map(
        "n",
        "<leader>jrv",
        refactor.extract_variable,
        "Extract Variable"
    ),

    map(
        "n",
        "<leader>jrc",
        refactor.extract_constant,
        "Extract Constant"
    ),

    map(
        "n",
        "<leader>jrm",
        refactor.extract_method,
        "Extract Method"
    ),

    map(
        "x",
        "<leader>jrv",
        function()
            refactor.extract_variable(true)
        end,
        "Extract Variable"
    ),

    map(
        "x",
        "<leader>jrc",
        function()
            refactor.extract_constant(true)
        end,
        "Extract Constant"
    ),

    map(
        "x",
        "<leader>jrm",
        function()
            refactor.extract_method(true)
        end,
        "Extract Method"
    ),

    ----------------------------------------------------------------------------
    -- Tests
    ----------------------------------------------------------------------------

    map(
        "n",
        "<leader>jtc",
        test.class,
        "Run Test Class"
    ),

    map(
        "n",
        "<leader>jtn",
        test.nearest,
        "Run Nearest Test"
    ),

    map(
        "n",
        "<leader>jtp",
        test.pick,
        "Pick Test"
    ),

}

--------------------------------------------------------------------------------
-- Spring
--------------------------------------------------------------------------------

if spring.exists() then
    vim.list_extend(
        mappings,
        require("bindings.keymaps.languages.java.spring")
    )
end

return mappings
