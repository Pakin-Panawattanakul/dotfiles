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

map = vim.keymap.set
-- Only create this keymap when lsp attach to buffer
local builtin = require("telescope.builtin")
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		vim.keymap.set("n", "gn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "LSP : [R]e[n]ame" })
		vim.keymap.set(
			{ "n", "v" },
			"<leader>ca",
			vim.lsp.buf.code_action,
			{ buffer = ev.buf, desc = "LSP : [C]ode [A]ction" }
		)
		vim.keymap.set(
			"n",
			"gw",
			builtin.lsp_workspace_symbols,
			{ buffer = ev.buf, desc = "LSP : [G]o to [W]orkspace symbols" }
		)
		vim.keymap.set(
			"n",
			"gs",
			builtin.lsp_document_symbols,
			{ buffer = ev.buf, desc = "LSP : [G]o Document [S]ymbols" }
		)
		vim.keymap.set(
			"n",
			"gr",
			builtin.lsp_references,
			{ nowait = true, buffer = ev.buf, desc = "LSP : [G]o to [R]efferences" }
		)
		vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = ev.buf, desc = "LSP : [G]o to [D]efinitions" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "LSP : [G]o to [D]eclaration" })
		vim.keymap.set(
			"n",
			"gi",
			builtin.lsp_implementations,
			{ buffer = ev.buf, desc = "LSP : [G]oto [I]mplemetations" }
		)
		vim.keymap.set(
			"n",
			"gt",
			builtin.lsp_type_definitions,
			{ buffer = ev.buf, desc = "LSP : [G]oto [T]ype definitions" }
		)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "LSP : Displays hover information" })
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
