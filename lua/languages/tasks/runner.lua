local tasks = require("languages.tasks")

local M = {}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

---@param root? string
---@param task TaskDefinition
---@param language string
---@param opts? TerminalRunOptions
function M.run(root, task, language, opts)
    if not root then
        vim.notify(
            ("Not inside a %s project."):format(language),
            vim.log.levels.ERROR
        )
        return
    end

    tasks.run(root, task, opts)
end

return M
