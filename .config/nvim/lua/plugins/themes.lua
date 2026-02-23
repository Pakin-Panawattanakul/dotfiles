return {
	{
		"navarasu/onedark.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("onedark").setup({
				style = "darker",
				transparent = true,
				code_style = {},
				colors = {
					black = "#07080d", -- regular0 / NvimDarkGrey1
					--[[ 
					bg0 = "#14161b", -- background / NvimDarkGrey2
					bg1 = "#2c2e33", -- bright0 / NvimDarkGrey3
					bg2 = "#4f5258", -- selection-background / NvimDarkGrey4
					bg3 = "#4f5258",
          --]]
					bg0 = "#07080d",
					bg1 = "#14161b", -- background / NvimDarkGrey2
					bg2 = "#2c2e33", -- bright0 / NvimDarkGrey3
					bg3 = "#4f5258", -- selection-background / NvimDarkGrey4
					bg_d = "#07080d",

					fg = "#e0e2ea", -- foreground / NvimLightGrey2
					grey = "#4f5258",
					light_grey = "#c4c6cd", -- regular7 / NvimLightGrey3

					red = "#ffc0b9", -- regular1
					green = "#b4f6c0", -- regular2
					yellow = "#fce094", -- regular3
					blue = "#a6dbff", -- regular4
					purple = "#ffcaff", -- regular5
					cyan = "#8cf8f7", -- regular6
					orange = "#fce094",

					dark_red = "#5e0009",
					dark_green = "#015825",
					dark_yellow = "#6e5600",
					dark_blue = "#005078",
					dark_purple = "#4c0049",
					dark_cyan = "#007676",

					diff_add = "#015825",
					diff_delete = "#5e0009",
					diff_change = "#005078",
					diff_text = "#007676",
				},

				highlights = {
					Comment = { fg = "#c4c6cd" },
					["@lsp.type.comment"] = { fg = "#c4c6cd" },
					["@comment"] = { fg = "#c4c6cd" },
					["@comment.error"] = { fg = "red", bold = true },
					["@comment.warning"] = { fg = "yellow", bold = true },
					["@comment.todo"] = { fg = "blue", bold = true },
				},
			})
			-- Enable theme
			require("onedark").load()
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({})

			-- vim.cmd("colorscheme github_dark_default")
		end,
	},
}
