local M = {}

function M.register(name, rhs, desc)
    vim.api.nvim_create_user_command(name, rhs, {
        desc = desc,
    })
end

return M
