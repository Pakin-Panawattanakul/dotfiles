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

-- /home fs
-- [[ commented because it needs Gio/Glib >= 2.54
local fs = lain.widget.fs({
	notification_preset = { fg = white, bg = theme.bg_normal, font = "Terminus 10.5" },
	settings = function()
		local fs_header, fs_p = "", ""

		if fs_now["/home"].percentage >= 90 then
			fs_header = " Hdd "
			fs_p = fs_now["/home"].percentage
		end

		widget:set_markup(markup.font(theme.font, markup(gray, fs_header) .. markup(white, fs_p)))
	end,
})

return fs
