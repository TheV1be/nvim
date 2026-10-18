return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- Renders pretty language icons
		event = "VeryLazy", -- Loads smoothly right after layout frames materialize
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto", -- Dynamically adopts whatever colorscheme you use
					component_separators = { left = "|", right = "|" },
					section_separators = { left = "", right = "" }, -- Smooth round bubble aesthetics
					globalstatus = true, -- Locks one clean statusline across all vertical splits
				},
				sections = {
					-- Left Side Sections
					lualine_a = { { "mode", separator = { left = "", right = "" } } },
					lualine_b = { "branch", "diff" },
					lualine_c = {
						{
							"filename",
							file_status = true, -- Displays modified flags [+][-]
							path = 1, -- 0 = Just filename, 1 = Relative path route
						},
					},
					-- Right Side Sections
					lualine_x = {
						{
							"diagnostics", -- Live hook directly into your pyright/clangd errors!
							sources = { "nvim_diagnostic" },
							symbols = { error = " ", warn = " ", info = " ", hint = "   " },
						},
						"encoding",
						"filetype",
					},
					lualine_y = { "progress" },
					lualine_z = { { "location", separator = { left = "", right = "" } } },
				},
			})
		end,
	},
}
