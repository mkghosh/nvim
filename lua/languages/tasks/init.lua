local strategy = require("languages.tasks.strategy")

local terminal = require("core.terminal")

local M = {}

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

---@param command TaskCommand
---@return string
local function build(command)
    return table.concat(
        vim.list_extend(
            { command.executable },
            command.arguments or {}
        ),
        " "
    )
end

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

---@param root string
---@param task TaskDefinition
---@param opts? TerminalTaskOptions
function M.run(root, task, opts)
    --------------------------------------------------------------------------
    -- Build System
    --------------------------------------------------------------------------

    local system = task.system or strategy.detect(root)

    --------------------------------------------------------------------------
    -- Executable
    --------------------------------------------------------------------------

    local executable = task.executable
        or strategy.executable(system)

    if not executable then
        vim.notify(
            ("No executable for '%s'."):format(system),
            vim.log.levels.ERROR
        )
        return
    end

    --------------------------------------------------------------------------
    -- Arguments
    --------------------------------------------------------------------------

    local arguments = task[system]

    if not arguments then
        vim.notify(
            ("No '%s' task defined."):format(system),
            vim.log.levels.ERROR
        )
        return
    end

    --------------------------------------------------------------------------
    -- Command
    --------------------------------------------------------------------------

    opts = vim.tbl_extend("force", {

        cwd = root,

        title = task.title,

        command = {

            executable = executable,

            arguments = vim.split(
                arguments,
                "%s+"
            ),

        },

    }, opts or {})

    --------------------------------------------------------------------------
    -- Terminal
    --------------------------------------------------------------------------

    terminal.task(
        build(opts.command),
        opts
    )
end

return M
