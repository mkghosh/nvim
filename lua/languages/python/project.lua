local metadata = require("languages.python.metadata")

local M = {}

--------------------------------------------------------------------------------
-- Project
--------------------------------------------------------------------------------

function M.root()
    return vim.fs.root(0, metadata.root_markers)
end

--------------------------------------------------------------------------------
-- Environment
--------------------------------------------------------------------------------

function M.venv()
    local root = M.root()

    if not root then
        return nil
    end

    local candidates = {
        ".venv",
        "venv",
    }

    for _, directory in ipairs(candidates) do
        local path = vim.fs.joinpath(root, directory)

        if vim.fn.isdirectory(path) == 1 then
            return path
        end
    end

    return nil
end

return M
