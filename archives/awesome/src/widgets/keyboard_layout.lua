local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local theme = require("src.theme")
local markup = lain.util.markup
-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()
mykeyboardlayout.widget.font = theme.font
local keyboard_icon = wibox.widget.textbox(markup.font(theme.font, " 󰌌"))
local keyboardwidget = wibox.widget({
	keyboard_icon,
	mykeyboardlayout,
	layout = wibox.layout.fixed.horizontal,
})

return keyboardwidget
