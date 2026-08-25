local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local beaufitul = require("beautiful")
local theme = require("src.theme")
local markup = lain.util.markup

-- Simple volume widget (icon + text)
local volume_icon = wibox.widget.textbox("  ")
local volume_text = wibox.widget.textbox("    ")
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

beaufitul.volume = lain.widget.alsa({
	settings = function()
		local vol_icon = "  "
		if volume_now.status == "off" then
			vol_icon = "  "
		elseif tonumber(volume_now.level) <= 30 then
			vol_icon = "  "
		end

		volume_icon:set_markup(markup.font(theme.font, vol_icon))
		volume_text:set_markup(markup.font(theme.font, volume_now.level .. "% "))
	end,
})
-- Add click functionality
local volume_widget = wibox.widget({
	volume_icon,
	volume_text,
	layout = wibox.layout.fixed.horizontal,
})

volume_widget:buttons(my_table.join(
	awful.button({}, 1, function()
		awful.spawn(string.format("%s -e alsamixer"))
	end),
	awful.button({}, 3, function()
		os.execute("amixer -q set Master toggle")
		theme.volume.update()
	end),
	awful.button({}, 4, function()
		os.execute("amixer -q set Master 5%+")
		theme.volume.update()
	end),
	awful.button({}, 5, function()
		os.execute("amixer -q set Master 5%-")
		theme.volume.update()
	end)
))

return volume_widget
