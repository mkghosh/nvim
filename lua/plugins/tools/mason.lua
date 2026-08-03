return {

	{

		"mason-org/mason.nvim",

		cmd = "Mason",

		opts = require("core.tools.config"),

		config = function(_, opts)
			require("mason").setup(opts)

			require("core.tools").setup()
		end,
	},
}
