return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    main = "nvim-treesitter.config",
    build = ":TSUpdate",

    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },

    opts = require("core.treesitter.config"),

    config = function(_, opts)
      require("nvim-treesitter.config").setup(opts)
      require("core.treesitter").setup()
    end,
  },
}
