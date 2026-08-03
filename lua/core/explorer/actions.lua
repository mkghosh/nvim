local M = {}

--------------------------------------------------------------------------------
-- Private
--------------------------------------------------------------------------------

---@param opts table
local function execute(opts)
    require("neo-tree.command").execute(opts)
end

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

---Toggle the filesystem explorer.
function M.toggle()
    execute({
        toggle = true,
        source = "filesystem",
    })
end

---Reveal the current file in the explorer.
---
---@param path? string
function M.reveal(path)
    execute({
        reveal = true,
        source = "filesystem",
        path = path or vim.api.nvim_buf_get_name(0),
    })
end

---Focus the explorer window.
function M.focus()
    vim.cmd("Neotree focus")
end

---Show open buffers.
function M.buffers()
    execute({
        source = "buffers",
    })
end

---Show Git status.
function M.git()
    execute({
        source = "git_status",
    })
end

return M
