return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- Adds language icons next to file names
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>e", ":Neotree toggle left<CR>", desc = "Toggle File Explorer Side Tree" },
	},
	opts = {
		window = { width = 30 },
		filesystem = {
			filtered_items = { hide_dotfiles = true },
		},
	},
}
