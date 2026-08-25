local lain = require("lain")
local theme = require("src.theme")

local clockwidget = require("src.widgets.textclock")
-- Calendar
local cal = lain.widget.cal({
	attach_to = { clockwidget },
	notification_preset = {
		fg = theme.fg_normal,
		bg = theme.bg_normal,
		position = "bottom_right",
		font = theme.font,
	}
})

return cal
