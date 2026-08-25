local lain = require("lain")
local wibox = require("wibox")
local markup = lain.util.markup
local theme = require("src.theme")

-- Create battery widgPt
local baticon = wibox.widget.textbox(" 󱊣 ")
local bat = lain.widget.bat({
	full_notify = "off",
	settings = function()
		local bat_icon = " 󱊣 "
		if bat_now.status and bat_now.status ~= "N/A" then
			if bat_now.ac_status == 1 then
				bat_icon = " 󰂄 "
			elseif bat_now.perc and tonumber(bat_now.perc) <= 33 then
				bat_icon = " 󱊡 "
			elseif bat_now.perc and tonumber(bat_now.perc) <= 66 then
				bat_icon = " 󱊢 "
			else
				bat_icon = " 󱊣 "
			end
			baticon:set_markup(markup.font(theme.font, bat_icon))
			widget:set_markup(markup.font(theme.font, bat_now.perc .. " % "))
		else
			widget:set_markup(markup.font(theme.font, "AC "))
			baticon:set_markup(markup.font(theme.font, "  "))
		end
	end,
})

local battery_widget = wibox.widget({
	baticon,
	bat.widget,
	layout = wibox.layout.fixed.horizontal,
})

return battery_widget
