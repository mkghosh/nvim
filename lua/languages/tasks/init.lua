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
---@param task table
---@param opts? TerminalRunOptions
function M.run(root, task, opts)
    local system = strategy.detect(root)

    local executable = strategy.executable(system)

    local arguments = task[system]

    if not executable then
        vim.notify(
            ("No executable for '%s'."):format(system),
            vim.log.levels.ERROR
        )
        return
    end

    if not arguments then
        vim.notify(
            ("No '%s' task defined."):format(system),
            vim.log.levels.ERROR
        )
        return
    end

    opts = vim.tbl_extend("force", {

        cwd = root,

        title = task.title,

        command = {

            executable = executable,

            arguments = vim.split(arguments, "%s+"),

        },

    }, opts or {})

    terminal.task(
        build(opts.command),
        opts
    )
end

return M
