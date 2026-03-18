return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = {
			"lua_ls",
			"pyright",
			"stylua",
			"rust_analyzer",
			"verible",
		},
		automatic_enable = {
			exclude = { "verible" },
		},
	},
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},
		{
			"neovim/nvim-lspconfig",
			dependencies = { "saghen/blink.cmp" },
		},
	},
}

-- Old sysntax pre nvim 0,11
--[[
This code does not merge with our own capabilities just using default
If have customized lsp config elsewhere merge the capabilites manually
ee : https://cmp.saghen.dev/installation

require('mason-lspconfig').setup(opts)
local installed_servers = require('mason-lspconfig').get_installed_servers()
local lspconfig = require('lspconfig')
for _, server in ipairs (installed_servers) do
  vim.lsp.enable(server)
end
]]
