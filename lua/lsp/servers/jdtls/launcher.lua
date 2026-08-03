local M = {}

local path = require("utils.path")
local jdtls = path.mason("packages", "jdtls")

function M.jar()
    local launcher = vim.fs.find(function(name)
        return name:match("^org%.eclipse%.equinox%.launcher_.*%.jar$")
    end, {
        path = jdtls .. "/plugins",
        limit = 1,
        type = "file",
    })[1]

    assert(launcher, "Unable to locate Equinox launcher")

    return launcher
end

function M.config()
    local os = vim.uv.os_uname().sysname

    local configs = {
        Linux = "config_linux",
        Darwin = "config_mac",
        Windows_NT = "config_win",
    }

    assert(configs[os], "Unsupported OS: " .. os)

    return jdtls .. "/" .. configs[os]
end

return M
