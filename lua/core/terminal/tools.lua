local launcher = require("core.terminal.launcher")
local layouts = require("core.terminal.layouts")

local M = {}

local function executable(cmd)
    return vim.fn.executable(cmd) == 1
end

local function tool(id, cmd, layout)
    if cmd and not executable(cmd) then
        vim.notify(cmd .. " is not installed", vim.log.levels.ERROR)
        return
    end

    launcher.toggle(cmd, layouts.get(layout or "float", {
        id = id,
        title = id,
    }))
end

function M.shell()
    launcher.toggle(nil, layouts.get("bottom", {
        id = "shell",
        title = "Shell",
    }))
end

function M.lazygit()
    tool("lazygit", "lazygit")
end

function M.htop()
    tool("htop", "htop")
end

function M.btop()
    tool("btop", "btop")
end

function M.lazydocker()
    tool("lazydocker", "lazydocker")
end

function M.k9s()
    tool("k9s", "k9s")
end

function M.yazi()
    tool("yazi", "yazi")
end

return M
