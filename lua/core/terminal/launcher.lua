local layouts = require("core.terminal.layouts")

local M = {}

--------------------------------------------------------------------------------
-- Private
--------------------------------------------------------------------------------

local function terminal()
    return require("snacks").terminal
end

--------------------------------------------------------------------------------
-- API
--------------------------------------------------------------------------------

---@param opts TerminalRunOptions
---@return snacks.win?
function M.run(opts)
    opts = opts or {}

    local layout = layouts.get(opts.layout or "float", {
        cwd = opts.cwd,
        env = opts.env,
        title = opts.title,
        id = opts.id,
        auto_insert = opts.auto_insert,
        auto_close = opts.auto_close,
    })

    local term = terminal().open(opts.cmd, layout)

    if term and term.buf then
        vim.b[term.buf].terminal_task = {
            title = opts.title,
            command = opts.cmd,
            cwd = opts.cwd,
            started = vim.uv.now(),
        }
    end

    return term
end

--------------------------------------------------------------------------------
-- Layouts
--------------------------------------------------------------------------------

---@param cmd string
---@param opts? TerminalTaskOptions
function M.task(cmd, opts)
    opts = vim.tbl_extend("force", {
        cmd = cmd,
        layout = "bottom",
        auto_close = false,
    }, opts or {})

    return M.run(opts)
end

---@param cmd string
---@param opts? TerminalTaskOptions
function M.float(cmd, opts)
    opts = vim.tbl_extend("force", {
        cmd = cmd,
        layout = "float",
    }, opts or {})

    return M.run(opts)
end

---@param cmd string
---@param opts? TerminalTaskOptions
function M.side(cmd, opts)
    opts = vim.tbl_extend("force", {
        cmd = cmd,
        layout = "right",
    }, opts or {})

    return M.run(opts)
end

--------------------------------------------------------------------------------
-- Snacks
--------------------------------------------------------------------------------

function M.toggle(cmd, opts)
    return terminal().toggle(cmd, opts)
end

function M.open(cmd, opts)
    return terminal().open(cmd, opts)
end

function M.focus(cmd, opts)
    return terminal().focus(cmd, opts)
end

function M.list()
    return terminal().list()
end

return M
