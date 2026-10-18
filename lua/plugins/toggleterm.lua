return {
	{
		"akinsho/toggleterm.nvim",
		version = "*", -- Fetch the stable semantic package releases
		event = "VeryLazy",
		keys = {
			-- Register the global terminal trigger key combo
			{ [[<C-\>]], "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Floating Terminal" },
		},
		opts = {
			open_mapping = [[<C-\>]], -- Let the same chord toggle it back shut
			start_in_insert = true, -- Automatically drops cursor into insert mode to start typing commands immediately
			insert_mappings = true, -- Makes sure your hotkey works while you are actively writing code text
			terminal_mappings = true, -- Makes sure your hotkey works while you are focused inside the console shell
			persist_size = true,
			close_on_exit = true, -- Automatically wipes the buffer box when your shell process terminates (e.g. typing 'exit')
			shell = vim.o.shell, -- Syncs directly to your system's default shell (bash, zsh, etc.)

			-- Style layout overrides to give it premium contrast borders
			float_opts = {
				border = "rounded", -- Smooth rounded border matching your LSP hover look
				winblend = 3, -- Subtle background transparency blend layer
				highlights = {
					border = "FloatBorder",
					background = "NormalFloat",
				},
			},
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)

			-- 🕹️ ESSENTIAL NAVIGATION SHORTCUTS INSIDE TERMINAL MODE
			-- This teaches Neovim how to exit terminal focus smoothly without clunky Vim syntax chords
			function _G.set_terminal_keymaps()
				local map_opts = { buffer = 0 }
				-- Press Escape to drop out of terminal input and move your cursor around the terminal text layout
				vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], map_opts)
				-- Quick grid pane jumps directly out of the terminal panel using your standard panel control mechanics
				vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], map_opts)
				vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], map_opts)
				vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], map_opts)
				vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], map_opts)
			end

			-- Run this shortcut bundle automatically every single time a terminal instance spawns
			vim.api.nvim_create_autocmd("TermOpen", {
				pattern = "term://*",
				callback = function()
					set_terminal_keymaps()
				end,
			})
		end,
	},
}
