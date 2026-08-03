local M = {}

local map = require("core.utils.keymap").set
local run = require("languages.java.spring.run")

function M.setup(bufnr)
    local opts = { buffer = bufnr }

    require("which-key").add({
        { "<leader>js", group = "Spring", buffer = bufnr },
    })

    map(
        "n",
        "<leader>jsr",
        run.run,
        "Run Spring Boot",
        opts
    )

    map(
        "n",
        "<leader>jsd",
        run.debug,
        "Debug Spring Boot",
        opts
    )
end

return M
