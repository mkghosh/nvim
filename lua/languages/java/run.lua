---@diagnostic disable: undefined-field

local util = require("jdtls.util")

local project = require("languages.java.project")
local terminal = require("core.terminal")

local M = {}

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

---@param value string
---@return string
local function shellescape(value)
    return vim.fn.shellescape(value)
end

---@param java_exec string
---@param main_class string
---@param module_paths string[]
---@param class_paths string[]
---@return string
local function build_command(
    java_exec,
    main_class,
    module_paths,
    class_paths
)
    local command = {
        shellescape(java_exec),
    }

    if #module_paths > 0 then
        table.insert(command, "--module-path")
        table.insert(
            command,
            shellescape(table.concat(module_paths, ":"))
        )
    end

    if #class_paths > 0 then
        table.insert(command, "-cp")
        table.insert(
            command,
            shellescape(table.concat(class_paths, ":"))
        )
    end

    table.insert(command, shellescape(main_class))

    return table.concat(command, " ")
end

--------------------------------------------------------------------------------
-- Run
--------------------------------------------------------------------------------

---@param entry? table
function M.run(entry)
    local root = project.root()

    if not root then
        vim.notify(
            "Not inside a Java project.",
            vim.log.levels.ERROR
        )
        return
    end

    local main_class

    if entry then
        main_class = entry.mainClass
    else
        main_class = util.resolve_classname()
    end

    if not main_class or main_class == "" then
        vim.notify(
            "Unable to determine the Java main class.",
            vim.log.levels.ERROR
        )
        return
    end

    local project_name = entry and entry.projectName or ""

    --------------------------------------------------------------------------
    -- Resolve Java executable
    --------------------------------------------------------------------------

    util.with_java_executable(
        main_class,
        project_name,
        function(java_exec)
            if not java_exec then
                vim.notify(
                    "Unable to resolve the Java executable.",
                    vim.log.levels.ERROR
                )
                return
            end

            ------------------------------------------------------------------
            -- Resolve classpath
            ------------------------------------------------------------------

            util.execute_command(
                {
                    command = "vscode.java.resolveClasspath",
                    arguments = {
                        main_class,
                        project_name,
                    },
                },
                function(err, paths)
                    if err then
                        vim.notify(
                            "Unable to resolve Java classpath: "
                            .. (err.message or vim.inspect(err)),
                            vim.log.levels.ERROR
                        )
                        return
                    end

                    if not paths then
                        vim.notify(
                            "JDTLS returned no Java classpath.",
                            vim.log.levels.ERROR
                        )
                        return
                    end

                    local module_paths = paths[1] or {}
                    local class_paths = paths[2] or {}

                    class_paths = vim.tbl_filter(
                        function(path)
                            return vim.fn.isdirectory(path) == 1
                                or vim.fn.filereadable(path) == 1
                        end,
                        class_paths
                    )

                    local command = build_command(
                        java_exec,
                        main_class,
                        module_paths,
                        class_paths
                    )

                    terminal.run({
                        cmd = command,
                        cwd = root,
                        title = "Java: Run",
                        id = "java-run",
                        layout = "bottom",
                        auto_close = false,
                    })
                end
            )
        end
    )
end

return M
