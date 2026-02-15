-- luacheck: globals vim
------------------- Neovim keymap --------------------
local map = vim.keymap.set
local opts = { noremap = true }
--map({"n", "v"}, "l", "k", opts)
--map({ "n", "v" }, "m", "h", opts)
--map({ "n", "v" }, "n", "j", opts)
--map({ "n", "v" }, "e", "k", opts)
--map({ "n", "v" }, "i", "l", opts)
--map({ "n", "v" }, "h", "i", opts)
--map({ "n", "v" }, "j", "n", opts)
--map({ "n", "v" }, "k", "m", opts)
--map({ "n", "v" }, "l", "e", opts)

--map({ "n", "v" }, "M", "H", opts)
--map({ "n", "v" }, "N", "J", opts)
--map({ "n", "v" }, "E", "K", opts)
--map({ "n", "v" }, "I", "L", opts)
--map({ "n", "v" }, "H", "I", opts)
--map({ "n", "v" }, "J", "N", opts)
--map({ "n", "v" }, "K", "M", opts)
--map({ "n", "v" }, "L", "E", opts)

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

-- buffers
vim.keymap.set("n", "<leader>n", ":bn<cr>", { desc = "[N]ext Buffer" })
vim.keymap.set("n", "<leader>p", ":bp<cr>", { desc = "[P]revious Buffer" })
vim.keymap.set("n", "<leader>x", ":bd<cr>", { desc = "[D]elete [B]uffer" })
vim.keymap.set("n", "<leader>bl", ":b#<cr>", { desc = "[Last] Open Buffer" })

-- Diagnostic
vim.keymap.set("n", "<leader>d", ":lua vim.diagnostic.open_float()<CR>", { desc = "Show [D]iagnostic" })

local function ToggleRelative()
	vim.wo.relativenumber = not vim.wo.relativenumber
end
vim.keymap.set("n", "<leader>tr", ToggleRelative, { desc = "[T]oggle [R]elative line number" })
