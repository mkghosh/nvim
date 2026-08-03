local M = {}

local layouts = {

    float = {
        win = {
            position = "float",
        },
    },

    bottom = {
        win = {
            position = "bottom",
        },
    },

    right = {
        win = {
            position = "right",
        },
    },

}

function M.get(name, opts)
    return vim.tbl_deep_extend(
        "force",
        layouts[name] or layouts.float,
        opts or {}
    )
end

return M
