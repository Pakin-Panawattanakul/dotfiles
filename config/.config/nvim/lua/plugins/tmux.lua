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
		{ "<C-H>", ":TmuxNavigateLeft<CR>" },
		{ "<C-J>", ":TmuxNavigateDown<CR>" },
		{ "<C-K>", ":TmuxNavigateUp<CR>" },
		{ "<C-L>", ":TmuxNavigateRight<CR>" },
	},
}
