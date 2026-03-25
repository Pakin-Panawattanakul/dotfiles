-- luacheck: globals vim
-- Add Blink.cmp capabilities
vim.lsp.config("slang-server", {
	cmd = { "slang-server" },
	root_markers = { ".git", ".slang" },
	filetypes = {
		"systemverilog",
		"verilog",
	},
})
vim.lsp.enable("slang-server")

local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("*", {
	capabilities = capabilities,
})

local map = vim.keymap.set

-- Only create this keymap when lsp attach to buffer
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "LSP : Rename" })
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "LSP : Code Action" })
		map(
			"n",
			"<leader>gw",
			":Pick lsp scope='workspace_symbol_live'<cr>",
			{ buffer = ev.buf, desc = "LSP : workspace symbols" }
		)
		map(
			"n",
			"<leader>gs",
			":Pick lsp scope='document_symbol'<cr>",
			{ buffer = ev.buf, desc = "LSP : Document Symbols" }
		)
		map(
			"n",
			"gR",
			":Pick lsp scope='references'<cr>",
			{ nowait = true, buffer = ev.buf, desc = "LSP : [G]o to [R]efferences" }
		)
		map("n", "gd", ":Pick lsp scope='definition'<cr>", { buffer = ev.buf, desc = "LSP : [D]efinitions" })
		map("n", "gD", ":Pick lsp scope='declaration'<cr>", { buffer = ev.buf, desc = "LSP : [G]o to [D]eclaration" })
		map(
			"n",
			"gi",
			"Pick lsp scope='implementatioin'<cr>",
			{ buffer = ev.buf, desc = "LSP : [G]oto [I]mplemetations" }
		)
		map("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "LSP : Displays hover information" })
		map("n", "<leader>rs", ":LspRestart<CR>", { buffer = ev.buf, desc = "LSP : restart LSP" })
	end,
})

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
local severity = vim.diagnostic.severity

vim.opt.winborder = "rounded"
vim.diagnostic.config({
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	virtual_text = true,
	signs = {
		text = {
			[severity.ERROR] = " ",
			[severity.WARN] = " ",
			[severity.HINT] = "󰠠 ",
			[severity.INFO] = " ",
		},
	},
})

--[[
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    vim.lsp.stop_client(vim.lsp.get_clients())
  end,
})
]]
vim.api.nvim_create_autocmd("LspDetach", {
	callback = function(args)
		-- Get the detaching client
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		-- Remove the autocommand to format the buffer on save, if it exists
		if client:supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				event = "BufWritePre",
				buffer = args.buf,
			})
		end
	end,
})
