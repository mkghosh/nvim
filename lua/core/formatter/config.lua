local formatters = require("core.formatter.formatters")

local M = {}

M.formatters_by_ft = formatters.by_ft

M.format_on_save = function(_)
    return {
        timeout_ms = 500,
        lsp_format = "fallback",
    }
end

return M
