local dap = require("dap")

local project = require("languages.python.project")

local M = {}

--------------------------------------------------------------------------------
-- Configuration
--------------------------------------------------------------------------------

local initialized = false

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

function M.setup()
    if initialized then
        return
    end

    initialized = true

    dap.configurations.python = {
        {
            type = "python",
            request = "launch",
            name = "Python: Current File",

            program = "${file}",

            pythonPath = function()
                return project.python()
            end,

            console = "integratedTerminal",

            justMyCode = true,

            cwd = function()
                return project.root() or vim.fn.getcwd()
            end,
        },

        {
            type = "python",
            request = "launch",
            name = "Python: Module",

            module = function()
                return vim.fn.input("Module: ")
            end,

            pythonPath = function()
                return project.python()
            end,

            console = "integratedTerminal",

            justMyCode = true,

            cwd = function()
                return project.root() or vim.fn.getcwd()
            end,
        },

        {
            type = "python",
            request = "launch",
            name = "Python: Pytest",

            module = "pytest",

            args = {
                "${file}",
            },

            pythonPath = function()
                return project.python()
            end,

            console = "integratedTerminal",

            justMyCode = true,

            cwd = function()
                return project.root() or vim.fn.getcwd()
            end,
        },
    }
end

return M
