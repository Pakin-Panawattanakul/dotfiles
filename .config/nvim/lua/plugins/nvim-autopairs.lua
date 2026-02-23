return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local npairs = require("nvim-autopairs")
		npairs.setup()
		npairs.remove_rule("`")
		vim.keymap.set(
			"n",
			"<leader>tp",
			":lua require('nvim-autopairs').toggle()<cr>",
			{ desc = "[T]oggle auto [P]airs" }
		)
	end,
}
