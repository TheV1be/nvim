return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- Visual language icons
		event = "VeryLazy", -- Loads smoothly right after layout frames materialize
		opts = {
			options = {
				mode = "buffers", -- Displays open file buffers as tabs
				separator_style = "slant", -- Gives tabs a beautiful angled slant edge
				always_show_bufferline = true,
				show_buffer_close_icons = true,
				show_close_icon = true,

				--  Add these lines to give the buttons an explicit visual symbol 
				buffer_close_icon = "x", -- The individual 'x' icon on each tab
				close_icon = "x", -- The master 'X' icon on the far right edge

				-- Integrates your pyright/clangd errors right inside the tabs!
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,

				-- Styling overrides for high contrast and modern styling
				offsets = {
					{
						filetype = "neo-tree",
						text = "📁 PROJECT DIRECTORY",
						text_align = "center",
						separator = true,
					},
				},
			},
		},
	},
}
