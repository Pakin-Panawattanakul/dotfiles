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
          -- lighther variant of blacks
					bg0 = "#14161b", -- background / NvimDarkGrey2
					bg1 = "#2c2e33", -- bright0 / NvimDarkGrey3
					bg2 = "#4f5258", -- selection-background / NvimDarkGrey4
					bg3 = "#4f5258",
          --]]
          -- darker variaint of blacks
					bg0 = "#07080d",
					bg1 = "#14161b", -- background / NvimDarkGrey2
					bg2 = "#2c2e33", -- bright0 / NvimDarkGrey3
					bg3 = "#4f5258", -- selection-background / NvimDarkGrey4
					bg_d = "#07080d",

					fg = "#e0e2ea", -- foreground / NvimLightGrey2
					grey = "#4f5258",
					light_grey = "#c4c6cd", -- regular7 / NvimLightGrey3

					red = "#ffc0b9", -- regular1
					green = "#b3f6c0", -- regular2
					yellow = "#fce094", -- regular3
					blue = "#a6dbff", -- regular4
					purple = "#ffcaff", -- regular5
					cyan = "#8cf8f7", -- regular6
					orange = "#fce094",

					dark_red = "#590008", -- regular1 (light) / NvimDarkRed
					dark_green = "#005523", -- regular2 (light) / NvimDarkGreen
					dark_yellow = "#6b5300", -- regular3 (light) / NvimDarkYellow
					dark_blue = "#004c73", -- regular4 (light) / NvimDarkBlue
					dark_purple = "#470045", -- regular5 (light) / NvimDarkMagenta
					dark_cyan = "#007373", -- regular6 (light) / NvimDarkCyan

					diff_add = "#005523",
					diff_delete = "#590008",
					diff_change = "#004c73",
					diff_text = "#007373",
				},

				highlights = {
					CursorLine = { bg = "NvimDarkGrey3" },
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
}
