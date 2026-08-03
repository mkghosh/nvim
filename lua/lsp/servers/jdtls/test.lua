---@diagnostic disable: undefined-field

local M = {}

local jdtls = require("jdtls")

function M.class()
    jdtls.test_class()
end

function M.nearest()
    jdtls.test_nearest_method()
end

function M.pick()
    jdtls.pick_test()
end

return M
