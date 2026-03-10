return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
		"TmuxNavigatorProcessList",
	},
	keys = {
		{ "<C-Left>", ":TmuxNavigateLeft<CR>" },
		{ "<C-Down>", ":TmuxNavigateDown<CR>" },
		{ "<C-Up>", ":TmuxNavigateUp<CR>" },
		{ "<C-Right>", ":TmuxNavigateRight<CR>" },
		{ "<C-\\>", ":TmuxNavigatePreviousgra<CR>" },
		-- {"<C-M>", ":TmuxNavigateLeft<CR>" },
		--	{ "<C-N>", ":TmuxNavigateDown<CR>" },
		--	{ "<C-E>", ":TmuxNavigateUp<CR>" },
		--	{ "<C-I>", ":TmuxNavigateRight<CR>" },
	},
}
