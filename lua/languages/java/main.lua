---@diagnostic disable: undefined-field

local util = require("jdtls.util")
local run = require("languages.java.run")

local dap = require("dap")

local M = {}

--------------------------------------------------------------------------------
-- Resolve
--------------------------------------------------------------------------------

---@param callback fun(classes: table[]?)
function M.resolve(callback)
    util.execute_command(
        {
            command = "vscode.java.resolveMainClass",
            arguments = {},
        },
        function(err, classes)
            if err then
                vim.notify(
                    "Unable to resolve Java main classes: "
                    .. (err.message or vim.inspect(err)),
                    vim.log.levels.ERROR
                )

                callback(nil)
                return
            end

            callback(classes or {})
        end
    )
end

--------------------------------------------------------------------------------
-- Pick
--------------------------------------------------------------------------------

---@param callback fun(entry: table)
function M.pick(callback)
    M.resolve(function(classes)
        if not classes or #classes == 0 then
            vim.notify(
                "No Java main classes found.",
                vim.log.levels.WARN
            )
            return
        end

        local items = {}

        for _, entry in ipairs(classes) do
            table.insert(items, {
                mainClass = entry.mainClass,
                projectName = entry.projectName,
                filePath = entry.filePath,
            })
        end

        vim.ui.select(
            items,
            {
                prompt = "Java Main Class",
                format_item = function(item)
                    return ("%s  [%s]"):format(
                        item.mainClass,
                        item.projectName
                    )
                end,
            },
            function(choice)
                if choice then
                    callback(choice)
                end
            end
        )
    end)
end

--------------------------------------------------------------------------------
-- Run selected
--------------------------------------------------------------------------------

function M.run()
    M.pick(function(entry)
        run.run(entry)
    end)
end

--------------------------------------------------------------------------------
-- Debug selected
--------------------------------------------------------------------------------

function M.debug()
    M.pick(function(entry)
        dap.run({
            type = "java",
            request = "launch",
            name = "Java: Debug",
            cwd = "${workspaceFolder}",

            mainClass = entry.mainClass,
            projectName = entry.projectName,
        })
    end)
end

return M
