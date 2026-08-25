local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local theme = require("src.theme")
local markup = lain.util.markup
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local function update_txt_layoutbox(s)
	-- Writes a string representation of the current layout in a textbox widget
	local txt_l = theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))] or ""
	s.mytxtlayoutbox:set_markup(markup.font(theme.font, txt_l))
end


local function setup(s)
	-- Textual layoutbox
	s.mytxtlayoutbox = wibox.widget.textbox(theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))])
	awful.tag.attached_connect_signal(s, "property::selected", function()
		update_txt_layoutbox(s)
	end)
	awful.tag.attached_connect_signal(s, "property::layout", function()
		update_txt_layoutbox(s)
	end)
	s.mytxtlayoutbox:buttons(my_table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 2, function()
			awful.layout.set(awful.layout.layouts[1])
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
  return s.mytxtlayoutbox
end

return setup
