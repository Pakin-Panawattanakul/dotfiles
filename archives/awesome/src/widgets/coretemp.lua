-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
	settings = function()
		widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
	end,
})
