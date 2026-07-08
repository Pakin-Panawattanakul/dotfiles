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
vim.cmd("cnoreabbrev LspInfo checkhealth vim.lsp")

local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("*", {
	capabilities = capabilities,
})

local map = vim.keymap.set

-- Only create this keymap when lsp attach to buffer
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local builtin = require("telescope.builtin")
		map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "LSP : Rename" })
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "LSP : Code Action" })
		map("n", "<leader>gw", builtin.lsp_workspace_symbols, { buffer = ev.buf, desc = "LSP : workspace symbols" })
		map("n", "<leader>gs", builtin.lsp_document_symbols, { buffer = ev.buf, desc = "LSP : Document Symbols" })
		map("n", "gr", builtin.lsp_references, { nowait = true, buffer = ev.buf, desc = "LSP : [G]o to [R]eferences" })
		map("n", "gd", builtin.lsp_definitions, { buffer = ev.buf, desc = "LSP : [D]efinitions" })
		map("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "LSP : [G]o to [D]eclaration" })
		map("n", "gi", builtin.lsp_implementations, { buffer = ev.buf, desc = "LSP : [G]oto [I]mplementations" })
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
