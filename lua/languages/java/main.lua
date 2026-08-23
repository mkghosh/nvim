---@diagnostic disable: undefined-field

local util = require("jdtls.util")
local run = require("languages.java.run")

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

function M.pick()
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
                main_class = entry.mainClass,
                project = entry.projectName,
                file = entry.filePath,
            })
        end

        vim.ui.select(
            items,
            {
                prompt = "Java Main Class",
                format_item = function(item)
                    return ("%s  [%s]"):format(
                        item.main_class,
                        item.project
                    )
                end,
            },
            function(choice)
                if not choice then
                    return
                end

                run.run({
                    mainClass = choice.main_class,
                    projectName = choice.project,
                    filePath = choice.file,
                })
            end
        )
    end)
end

return M
