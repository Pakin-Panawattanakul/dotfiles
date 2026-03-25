-- luacheck: globals vim
local map = function(key, map, opts)
	vim.keymap.set("n", key, map, opts)
end

return {
	{
		"nvim-mini/mini.extra",
		version = false,
		config = function()
			require("mini.extra").setup({})
			map("<leader>D", ":Pick diagnostic scope='current'<cr>", { desc = "Diagonstic current buffer" })
			map("<leader>fd", ":Pick diagnostic scope='all'<cr>", { desc = "Diagonstic all buffer" })
			map("<leader>fM", ":Pick manpages<cr>", { desc = "Find Manpages" })
			map("<leader>fm", ":Pick marks<cr>", { desc = "Find Mark" })
		end,
	},

	{
		"nvim-mini/mini.pick",
		version = false,
		config = function()
			require("mini.pick").setup({})
			map("<leader>ff", ":Pick files<cr>", {})
			map("<leader>fh", ":Pick help<cr>", {})
			map("<leader>fg", ":Pick grep_live<cr>", {})
			map("<leader><leader>", ":Pick buffers<cr>", {})
		end,
	},
}
