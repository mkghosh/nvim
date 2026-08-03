---@diagnostic disable: undefined-field

local M = {}

local jdtls = require("jdtls")

function M.organize_imports()
    jdtls.organize_imports()
end

function M.extract_method(visual)
    jdtls.extract_method(visual)
end

function M.extract_variable(visual)
    jdtls.extract_variable(visual)
end

function M.extract_constant(visual)
    jdtls.extract_constant(visual)
end

return M
