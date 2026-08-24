local map = require("utils.keymap").set

local actions = require("languages.java.actions")
local workspace = require("languages.java.workspace")

local refactor = require("lsp.servers.jdtls.refactor")
local test = require("lsp.servers.jdtls.test")

local spring = require("languages.java.spring.project")

local java_run = require("languages.java.run")

local java_main = require("languages.java.main")

local navigation = require("languages.java.navigation")

local code_action = require("languages.java.code_action")

local codelens = require("languages.java.codelens")

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
    -- Run / Debug
    ----------------------------------------------------------------------------

    map(
        "n",
        "<leader>jrr",
        java_run.run,
        "Run Java Application"
    ),

    map(
        "n",
        "<leader>jrm",
        java_main.run,
        "Select Main Class and Run"
    ),

    map(
        "n",
        "<leader>jdr",
        function()
            local dap = require("dap")

            dap.run(
                dap.configurations.java[1]
            )
        end,
        "Debug Java Application"
    ),

    map(
        "n",
        "<leader>jdm",
        java_main.debug,
        "Select Main Class and Debug"
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

    ----------------------------------------------------------------------------
    -- Navigation
    ----------------------------------------------------------------------------

    map(
        "n",
        "<leader>jnd",
        navigation.definition,
        "Go to Definition"
    ),

    map(
        "n",
        "<leader>jnn",
        navigation.declaration,
        "Go to Declaration"
    ),

    map(
        "n",
        "<leader>jni",
        navigation.implementation,
        "Go to Implementation"
    ),

    map(
        "n",
        "<leader>jnt",
        navigation.type_definition,
        "Go to Type Definition"
    ),

    map(
        "n",
        "<leader>jnr",
        navigation.references,
        "Find References"
    ),

    map(
        "n",
        "<leader>jns",
        navigation.document_symbols,
        "Document Symbols"
    ),

    map(
        "n",
        "<leader>jnw",
        navigation.workspace_symbols,
        "Workspace Symbols"
    ),

    map(
        "n",
        "<leader>jnc",
        navigation.incoming_calls,
        "Incoming Calls"
    ),

    map(
        "n",
        "<leader>jno",
        navigation.outgoing_calls,
        "Outgoing Calls"
    ),

    map(
        "n",
        "<leader>jnh",
        navigation.type_hierarchy,
        "Type Hierarchy"
    ),

    ----------------------------------------------------------------------------
    -- Code Actions
    ----------------------------------------------------------------------------

    map(
        "n",
        "<leader>jca",
        code_action.actions,
        "Java Code Actions"
    ),

    map(
        "n",
        "<leader>jcs",
        code_action.source_actions,
        "Java Source Actions"
    ),

    map(
        "n",
        "<leader>jcq",
        code_action.quickfix,
        "Java Quick Fix"
    ),

    ----------------------------------------------------------------------------
    -- CodeLens
    ----------------------------------------------------------------------------

    map(
        "n",
        "<leader>jcl",
        codelens.toggle,
        "Toggle CodeLens"
    ),

    map(
        "n",
        "<leader>jcr",
        codelens.refresh,
        "Refresh CodeLens"
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
