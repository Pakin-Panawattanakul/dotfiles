-- luacheck: globals vim
------------------- Neovim keymap --------------------
-- vim-powered terminal in split window
-- space bar leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- ignore capitailzation mistakes
vim.cmd("ca W w")
vim.cmd("ca Q q")
vim.cmd("ca WQ wq")
vim.cmd("ca Wq wq")
vim.keymap.set("n", "<leader>q", ":q<cr>", { desc = "[Q]uit Vim!!" })
vim.keymap.set("n", "<leader>w", ":w<cr>", { desc = "[W]rite buffer" })
vim.keymap.set("n", "<leader>c", ":q!<cr>", { desc = "Quit without save" })

vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
-- buffers
vim.keymap.set("n", "<leader>n", ":bn<cr>", { desc = "[N]ext Buffer" })
vim.keymap.set("n", "<leader>p", ":bp<cr>", { desc = "[P]revious Buffer" })
vim.keymap.set("n", "<leader>x", ":bd<cr>", { desc = "[D]elete [B]uffer" })
vim.keymap.set("n", "<leader>bl", ":b#<cr>", { desc = "[Last] Open Buffer" })

-- Diagnostic
vim.keymap.set("n", "<leader>d", ":lua vim.diagnostic.open_float()<CR>", { desc = "Show [D]iagnostic" })
vim.keymap.set(
	"n",
	"<leader>D",
	"<cmd>Telescope diagnostics bufnr=0<CR>",
	{ desc = "Show [D]iagnostic current buffer" }
)
-- open buffer diagnostic with telescope

local function ToggleRelative()
	vim.wo.relativenumber = not vim.wo.relativenumber
end
vim.keymap.set("n", "<leader>tr", ToggleRelative, { desc = "[T]oggle [R]elative line number" })

-- terminal
vim.keymap.set("n", "<leader>tt", ":term<cr>",{})
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>",{})
