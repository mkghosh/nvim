local jdtls = require("jdtls")

local M = {}

--------------------------------------------------------------------------------
-- Generic Code Actions
--------------------------------------------------------------------------------

function M.actions()
    vim.lsp.buf.code_action()
end

function M.source_actions()
    vim.lsp.buf.code_action({
        context = {
            only = { "source" },
        },
    })
end

function M.quickfix()
    vim.lsp.buf.code_action()
end

--------------------------------------------------------------------------------
-- Java Source Generation
--------------------------------------------------------------------------------

local function execute(command, description)
    local fn = jdtls.commands[command]

    if not fn then
        vim.notify(
            description .. " is not supported by the current JDTLS",
            vim.log.levels.WARN
        )
        return
    end

    fn()
end

function M.generate_constructor()
    execute(
        "java.action.generateConstructorsPrompt",
        "Generate Constructor"
    )
end

function M.generate_delegate_methods()
    execute(
        "java.action.generateDelegateMethodsPrompt",
        "Generate Delegate Methods"
    )
end

function M.generate_to_string()
    execute(
        "java.action.generateToStringPrompt",
        "Generate toString"
    )
end

function M.generate_equals_hashcode()
    execute(
        "java.action.hashCodeEqualsPrompt",
        "Generate equals/hashCode"
    )
end

function M.override_methods()
    execute(
        "java.action.overrideMethodsPrompt",
        "Override Methods"
    )
end

return M
