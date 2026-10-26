return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.config")

			configs.setup({
				ensure_installed = {
					"lua",
					"c",
					"cpp",
					"python",
					"java",
					"vim",
					"vimdoc",
					"markdown",
					"markdown_inline",
					"query",
					"html",
					"css",
					"javascript",
					"typescript",
					"tsx",
				},
				sync_install = false,
				indent = { enable = true },
				auto_install = true,
				highlight = {
					enable = true,
				},
			})
		end,
	},
}
