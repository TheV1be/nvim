-- Set <leader> to space
vim.g.mapleader = " "

-- Files explorer
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex, { desc = "Open netrw" })

-- Quick window splitting shortcuts
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })

-- Quick background buffer navigation (Shift + h/l)
vim.keymap.set("n", "<leader>k", ":bprevious<CR>", { desc = "Go to previous file buffer" })
vim.keymap.set("n", "<leader>j", ":bnext<CR>", { desc = "Go to next file buffer" })

-- Quick window layout cleanup shortcuts
vim.keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close active split pane" })
vim.keymap.set("n", "<leader>so", ":only<CR>", { desc = "Maximize current split pane" })

-- Close the current active file buffer tray slot instantly
vim.keymap.set("n", "<leader>bx", ":bdelete<CR>", { desc = "Close active file tab" })

-- Copy the current file's folder directory path to your system clipboard
vim.keymap.set("n", "<leader>yd", function()
	local dir = vim.fn.expand("%:p:h")
	vim.fn.setreg("+", dir)
	print("Copied directory: " .. dir)
end, { desc = "Copy current directory path to clipboard" })
