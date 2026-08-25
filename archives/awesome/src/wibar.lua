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

local myshape = function(cr, width, height)
	gears.shape.rounded_rect(cr, width, height, 2)
end

local widget_highlight = function(wid, bg)
	local default_bg = theme.bg_normal .. "AA"
	local bg_color = bg or default_bg
	local margin = wibox.container.margin(wid, dpi(6), dpi(6), 0, 0)
	local background = wibox.container.background(margin, bg_color, myshape)
	if bg_color ~= default_bg then
		local fg_color = theme.colors.bg
		background.fg = fg_color
	end
	return wibox.container.margin(background, dpi(4), dpi(4), dpi(3), dpi(3))
end

--------------------- Load widgets Module ---------------------
-- List of widgets in the wibar
local widgets_dir = "src.widgets."
beautiful.clock_widget = require(widgets_dir .. "textclock")
beautiful.mpd_widget = require(widgets_dir .. "mpd")
--beautiful.mpd_widget = lain.widget.mpd()
beautiful.volume_widget = require(widgets_dir .. "volume")
beautiful.keyboard_widget = require(widgets_dir .. "keyboard_layout")
beautiful.battery_widget = require(widgets_dir .. "battery")
-- Widgets that are not in the wibar
beautiful.cal = require(widgets_dir .. "calendar")

-- Unused widgets
-- local systray = wibox.widget.systray()
-- local net = require(widgets_dir .. "net")
-- local fs = require("widgets_dir .. "file_system"")

local awesome_icon = wibox.widget.textbox(markup.font("JetBrains Mono Nerd Font 15", "  "))
local arch_icon =
	wibox.widget.textbox(markup.font("JetBrains Mono Nerd Font 15", markup.fg.color(theme.arch_blue, "   ")))

--------------------- Per-screen widgets ---------------------
local mytxtlayoutbox = require(widgets_dir .. "layoutbox")
function beautiful.at_screen_connect(s)
	-- setup Tags
	awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

  s.layoutbox = mytxtlayoutbox(s)

	-- Create a promptbox for each screen
	--s.mypromptbox = awful.widget.prompt()

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = awful.util.taglist_buttons,
		style = {
			font = "JetBrains Mono Nerd Font Bold 13",
		},
	})

	-- Create a tasklist widget
	--	s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		layout = {
			spacing_widget = {
				{
					forced_width = 5,
					forced_height = 24,
					thickness = 1,
					color = "#777777",
					widget = wibox.widget.separator,
				},
				valign = "center",
				halign = "center",
				widget = wibox.container.place,
			},
			spacing = 1,
			layout = wibox.layout.fixed.horizontal,
		},
		-- Notice that there is *NO* wibox.wibox prefix, it is a template,
		-- not a widget instance.
		widget_template = {
			{
				wibox.widget.base.make_widget(),
				forced_height = 5,
				id = "background_role",
				widget = wibox.container.background,
			},
			{
				{
					id = "clienticon",
					widget = awful.widget.clienticon,
				},
				margins = 5,
				widget = wibox.container.margin,
			},
			nil,
			create_callback = function(self, c, index, objects) --luacheck: no unused args
				self:get_children_by_id("clienticon")[1].client = c
			end,
			layout = wibox.layout.align.vertical,
		},
	})

  s.mypromptbox = awful.widget.prompt()
	s.mywibar = awful.wibar({
		position = "bottom",
		screen = s,
		height = theme.wibar_height,
		bg = theme.bg_normal .. "F2",
		fg = theme.fg_normal,
	})
	-- Add widgets to the wibox
	s.mywibar:setup({
		layout = wibox.layout.align.horizontal,
		expand = "outside",
		{
			widget_highlight(wibox.container.margin(arch_icon, dpi(5), dpi(20), 0, 0)),
			beautiful.mpd_widget,
      s.mypromptbox,
			expand = "inside",
			layout = wibox.layout.align.horizontal,
		},
		s.mytaglist,
		{
			layout = wibox.layout.align.horizontal,
			expand = "inside",
			nil,
			nil,
			{
				layout = wibox.layout.fixed.horizontal,
				widget_highlight(beautiful.keyboard_widget, theme.colors.red),
				theme.space,
				--theme.mail.widget,
				widget_highlight(s.layoutbox, theme.colors.purple),
				theme.space,
				widget_highlight(beautiful.volume_widget, theme.colors.green),
				theme.space,
				widget_highlight(beautiful.battery_widget, theme.colors.yellow),
				theme.space,
				widget_highlight(beautiful.clock_widget, theme.colors.blue),
				theme.space,
				theme.space,
			},
		},
	}) --]]
end

return theme
