---@meta

--------------------------------------------------------------------------------
-- Autocmd
--------------------------------------------------------------------------------

---@class AutocmdGroupOptions
---@field clear? boolean

---@class AutocmdOptions : vim.api.keyset.create_autocmd
---@field group? string|integer

---@class AutocmdDefinition
---@field event string|string[]
---@field group? string|integer
---@field pattern? string|string[]
---@field buffer? integer
---@field callback? fun(args: vim.api.keyset.create_autocmd.callback_args)
---@field command? string
---@field once? boolean
---@field nested? boolean
---@field desc? string

--------------------------------------------------------------------------------
-- Terminal
--------------------------------------------------------------------------------

---@class TerminalRunOptions
---@field cmd string
---@field cwd? string
---@field env? table<string, string>
---@field title? string
---@field id? string
---@field layout? "float"|"bottom"|"right"
---@field auto_insert? boolean

--------------------------------------------------------------------------------
-- Commands
--------------------------------------------------------------------------------

---@class CommandDefinition
---@field name string
---@field callback string|function
---@field desc? string
---@field opts? vim.api.keyset.user_command

--------------------------------------------------------------------------------
-- Keymaps
--------------------------------------------------------------------------------

---@class KeymapDefinition
---@field mode? string|string[]
---@field lhs string
---@field rhs string|function
---@field desc? string
---@field opts? vim.keymap.set.Opts

--------------------------------------------------------------------------------
-- Formatter
--------------------------------------------------------------------------------

---@class FormatterOptions
---@field async? boolean
---@field timeout_ms? integer
---@field lsp_format? boolean|string

--------------------------------------------------------------------------------
-- Explorer
--------------------------------------------------------------------------------

---@class ExplorerOptions
---@field source? "filesystem"|"buffers"|"git_status"|"diagnostics"
---@field toggle? boolean
---@field reveal? boolean
---@field path? string
---@field position? string

--------------------------------------------------------------------------------
-- Search
--------------------------------------------------------------------------------

---@class SearchOptions
---@field cwd? string
---@field hidden? boolean
---@field no_ignore? boolean

--------------------------------------------------------------------------------
-- Lazy.nvim
--------------------------------------------------------------------------------

---@class LazyKeyDefinition
---@field [1] string
---@field [2] string|function
---@field mode? string|string[]
---@field desc? string

--------------------------------------------------------------------------------
-- LSP
--------------------------------------------------------------------------------

---@class LspServerOptions
---@field capabilities? lsp.ClientCapabilities
---@field settings? table
---@field filetypes? string[]
---@field root_markers? string[]
---@field cmd? string[]
---@field init_options? table
---@field handlers? table
---@field flags? table
---@field on_attach? fun(client: vim.lsp.Client, bufnr: integer)

--------------------------------------------------------------------------------
-- Tasks
--------------------------------------------------------------------------------

---@class TaskDefinition
---@field title string
---@field go? string
---@field make? string
---@field task? string
---@field mage? string
---@field cargo? string
---@field npm? string
---@field pnpm? string
---@field bun? string
---@field maven? string
---@field gradle? string

---@class TaskCommand
---@field executable string
---@field arguments? string[]

---@class TaskRunOptions : TerminalRunOptions
---@field command TaskCommand

--------------------------------------------------------------------------------
-- Java
--------------------------------------------------------------------------------

---@alias JavaBuildSystem
---| "maven"
---| "gradle"

---@class JavaToolchain
---@field system JavaBuildSystem
---@field executable string
