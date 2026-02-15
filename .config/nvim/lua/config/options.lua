-------------------- Neovim options --------------------
-- luacheck:globals vim
--vim.cmd[[colorscheme tokyonight]]
-- Basic settings
vim.opt.number = true -- enable line number
vim.opt.relativenumber = true --enable relative linenumber
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.sidescroll = 8
vim.opt.sidescrolloff = 10
-- hide the bottom part of neovim
--vim.opt.laststatus = 0
--vim.opt.cmdheight = 0

-- Color scheme
vim.opt.termguicolors = true

-- Indentation
vim.opt.tabstop = 2 -- Tab width
vim.opt.shiftwidth = 2 -- Indent width
vim.opt.softtabstop = 2 -- Soft tab stop
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true -- Copy indent from current line

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"
-- Save undo history
vim.opt.undofile = true
--vim.opt.confirm = true -- Confirm y/n when closing unwritten file

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"
vim.g.have_nerd_font = true

-- Custom status line
-- Synce neovim clipboard with OS
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

