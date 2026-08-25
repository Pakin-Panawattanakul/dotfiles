-- Textclock
local wibox = require("wibox")
local lain = require("lain")
local awful = require("awful")
local theme = require("src.theme")

local markup = lain.util.markup

local clockicon = wibox.widget.textbox(markup.font(theme.font, " 󰥔 "))
local clock = awful.widget.watch("date +'%R'", 60, function(widget, stdout)
	widget:set_markup( markup.font(theme.font, stdout))
end)
local clockwidget = wibox.widget({
	clockicon,
	clock,
	theme.space,
	layout = wibox.layout.fixed.horizontal,
})

return clockwidget
