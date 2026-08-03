return {
    {
        "rcarriga/nvim-dap-ui",

        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },

        opts = require("core.debugger.ui").opts,
    },
}
