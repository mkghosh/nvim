local M = {}

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

---Open a directory in the directory explorer.
---
---@param path? string
function M.open(path)
    require("oil").open(path)
end

return M
