local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local naughty = require("naughty")
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local theme = require("src.theme")
local beautiful = require("beautiful")
local markup = lain.util.markup

-- Net
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net({
	settings = function()
		widget:set_markup(
			markup.font(
				theme.font,
				markup("#7AC82E", " " .. string.format("%06.1f", net_now.received))
					.. " "
					.. markup("#46A8C3", " " .. string.format("%06.1f", net_now.sent) .. " ")
			)
		)
	end,
})

local net_widget = wibox.widget({
  neticon,
  net,
  layout = wibox.layout.fixed.horizontal
})

return net_widget
