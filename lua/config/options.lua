-- OPTIONS
local set = vim.opt

--line nums
set.relativenumber = true
set.number = true

-- indentation and tabs
set.tabstop = 4
set.shiftwidth = 4
set.autoindent = true
set.expandtab = true

-- search settings
set.ignorecase = true
set.smartcase = true

-- appearance
--set.termguicolors = true
--set.background = "dark"
--set.signcolumn = "yes"

-- cursor line
set.cursorline = true

-- backspace
set.backspace = "indent,eol,start"

-- split windows
set.splitbelow = true
set.splitright = true

-- dw/diw/ciw works on full-word
set.iskeyword:append("-")

-- incremental search
set.incsearch = true

-- faster cursor hold
set.updatetime = 50

-- scrolloff and wrap
set.wrap = false
set.scrolloff = 10
set.sidescrolloff = 10

-- permanent 1-row blank margin right above code files
set.winbar = " "

-- floating window colors
set.termguicolors = true

-- force floating windows to have clean, high-contrast aesthetics
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" }) -- Syncs background directly to editor canvas
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#7aa2f7" }) -- Sets a beautiful clean steel blue outline border
vim.api.nvim_set_hl(0, "LspInfoBorder", { fg = "#7aa2f7" }) -- Keeps system info windows clean and matching

-- =====================================================================
-- 📁 Netrw Line Numbers Configuration Override
-- =====================================================================
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.opt_local.number = true -- Displays absolute numbers
		vim.opt_local.relativenumber = true -- Displays relative numbers
	end,
})
