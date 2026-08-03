return {

	{

		"mason-org/mason-lspconfig.nvim",

		dependencies = {

			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},

		opts = require("core.tools.lsp"),
	},
}
