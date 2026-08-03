local appearance = require("core.completion.appearance")
local keymaps = require("core.completion.keymaps")
local sources = require("core.completion.sources")
local snippets = require("core.completion.snippets")

local M = {}

M.keymap = keymaps.keymap

M.appearance = appearance

M.sources = {
    default = sources.default,
}

M.snippets = snippets

M.completion = {
    documentation = {
        auto_show = true,
    },
}

return M
