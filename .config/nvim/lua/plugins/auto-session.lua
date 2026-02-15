return {
	"rmagatti/auto-session",
	lazy = false,
	config = function()
		local auto_session = require("auto-session")
		local opts = {
			auto_save = true,
			auto_restore = true,
			auto_create = true,
			auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
			session_lens = {
				picker = "telescope",
				load_on_setup = true,
			},
		}

		auto_session.setup(opts)
		local builtin = require("telescope").builtin
		local keymap = vim.keymap
		keymap.set("n", "<leader>ss", "<cmd>AutoSession save<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
		keymap.set("n", "<leader>sr", "<cmd>AutoSession search<CR>", { desc = "Search sessions" })
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
	end,
}
