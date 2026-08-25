local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local naughty = require("naughty")

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

-- Arch-specific colors
local arch_blue = "#1793d1" -- Arch Linux blue
local arch_grey = "#2f2f2f" -- dark grey

-- colors scheme : Tokyonight, One-dark
colors = require("src.assets.colors.onedark")

local theme = {}
theme.default_dir = require("awful.util").get_themes_dir() .. "default"
theme.dir = os.getenv("HOME") .. "/.config/awesome/src/assets"
theme.font = "JetBrains Mono Nerd Font Propo 11"
theme.desktop_font = "JetBrains Mono Nerd Font Bold 11"

theme.fg_normal = "#FFFFFF"
theme.fg_focus = colors.blue
theme.fg_urgent = colors.red
theme.fg_minimize = colors.comment
-- Backgrounds
theme.bg_normal = colors.bg
theme.bg_focus = colors.bg_lighter
theme.bg_urgent = colors.bg
theme.bg_minimize = colors.selection
theme.bg_bar = colors.bg
-- Borders
theme.border_width = 2
theme.border_normal = colors.line
theme.border_focus = arch_blue .. "AA"
theme.border_marked = colors.red
-- Tasklist
theme.tasklist_bg_focus = colors.blue .. "AA"
theme.tasklist_bg_normal = colors.bg_light
theme.tasklist_fg_focus = colors.fg_light
theme.tasklist_fg_normal = colors.fg
-- Taglist
theme.taglist_fg_focus = colors.fg_light
theme.taglist_bg_focus = colors.blue .. "55"
theme.taglist_fg_normal = colors.fg
theme.taglist_bg_normal = "transparent"
-- Titlebar
theme.titlebar_bg_focus = colors.bg
theme.titlebar_bg_normal = colors.bg_light
theme.titlebar_fg_focus = colors.fg_light
theme.titlebar_fg_normal = colors.fg
theme.titlebar_border_focus = colors.blue
theme.titlebar_border_normal = colors.line

-- Hotkeys
theme.hotkeys_modifiers_fg = colors.fg_light
theme.colors = colors

-- Systray
theme.systray_icon_spacing = dpi(4)
theme.bg_systray = arch_grey

theme.wibar_height = dpi(26)

theme.menu_height = dpi(16)
theme.menu_width = dpi(140)
theme.ocol = "<span color='" .. theme.fg_normal .. "'>"
theme.tasklist_sticky = theme.ocol .. "[S]</span>"
theme.tasklist_ontop = theme.ocol .. "[T]</span>"
theme.tasklist_floating = theme.ocol .. "[F]</span>"
theme.tasklist_maximized_horizontal = theme.ocol .. "[M] </span>"
theme.tasklist_maximized_vertical = ""
theme.awesome_icon = theme.dir .. "/icons/awesome.png"
theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"
theme.useless_gap = 5
-- Titlebar buttons (red, yellow, green circles)
theme.titlebar_close_button_normal = theme.dir .. "/icons/titlebar/close.png"
theme.titlebar_close_button_focus = theme.dir .. "/icons/titlebar/close.png"
theme.titlebar_minimize_button_normal = theme.dir .. "/icons/titlebar/minimize.png"
theme.titlebar_minimize_button_focus = theme.dir .. "/icons/titlebar/minimize.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximize.png"
theme.titlebar_maximized_button_focus_inactive = theme.dir .. "/icons/titlebar/maximize.png"
theme.titlebar_maximized_button_normal_active = theme.dir .. "/icons/titlebar/maximize.png"
theme.titlebar_maximized_button_focus_active = theme.dir .. "/icons/titlebar/maximize.png"
-- themes for wigets yanked from power-arrow dark
theme.widget_net = theme.dir .. "/icons/net.png"
theme.widget_temp = theme.dir .. "/icons/temp.png"
-- lain related
theme.layout_txt_tile = "[t]"
theme.layout_txt_tileleft = "[l]"
theme.layout_txt_tilebottom = "[b]"
theme.layout_txt_tiletop = "[tt]"
theme.layout_txt_fairv = "[fv]"
theme.layout_txt_fairh = "[fh]"
theme.layout_txt_spiral = "[s]"
theme.layout_txt_dwindle = "[d]"
theme.layout_txt_max = "[m]"
theme.layout_txt_fullscreen = "[F]"
theme.layout_txt_magnifier = "[M]"
theme.layout_txt_floating = "[*]"
theme.layout_txt_cascade = "[cascade]"
theme.layout_txt_cascadetile = "[cascadetile]"
theme.layout_txt_centerwork = "[centerwork]"
theme.layout_txt_termfair = "[termfair]"
theme.layout_txt_centerfair = "[centerfair]"
-- Yank from holo
theme.taglist_squares_sel = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel = theme.dir .. "/icons/square_unsel.png"

-- Notication
--theme.notification_max_width = dpi(400)
--theme.notifiaction_max_height = dpi(80)

local markup = lain.util.markup

local space = wibox.widget.textbox("  ")

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

myshape = function(cr, width, height)
	gears.shape.rounded_rect(cr, width, height, 2)
end

-- Textclock
local clockicon = wibox.widget.textbox(markup.font(theme.font, " 󰥔 "))
local clock = awful.widget.watch("date +'%R'", 60, function(widget, stdout)
	widget:set_markup(" " .. markup.font(theme.font, stdout))
end)
local clockwidget = wibox.widget({
	clockicon,
	clock,
	space,
	layout = wibox.layout.fixed.horizontal,
})

-- Calendar
theme.cal = lain.widget.cal({
	attach_to = { clockwidget },
	notification_preset = {
		fg = theme.fg_normal,
		bg = theme.bg_normal,
		position = "top_middle",
		font = theme.font,
	},
})

-- MPD
--local musicplr = awful.util.terminal .. " -title Music -e ncmpcpp"
local mpd_icon = wibox.widget.textbox(markup.font(theme.font, " "))
theme.mpd = lain.widget.mpd({
	settings = function()
		if mpd_now.state == "play" then
			artist = mpd_now.artist .. " "
			title = mpd_now.title .. " "
			mpd_icon:set_markup(markup.font(theme.font, "   "))
		elseif mpd_now.state == "pause" then
			mpd_icon:set_markup(markup.font(theme.font, " 󰝛 "))
			artist = " mpd "
			title = "paused "
		else
			artist = ""
			title = ""
			mpd_icon:set_markup(markup.font(theme.font, "  ")) --󰝛
		end
		widget:set_markup(markup.font(theme.font, markup(theme.colors.purple, artist) .. title))
	end,
})
local mpd_widget = wibox.widget({
	mpd_icon,
	theme.mpd,
	layout = wibox.layout.fixed.horizontal,
})
mpd_widget:buttons(my_table.join(
	--awful.button({ "Mod4" }, 1, function () awful.spawn(musicplr) end),
	awful.button({}, 1, function()
		os.execute("mpc prev")
		theme.mpd.update()
	end),
	awful.button({}, 2, function()
		os.execute("mpc toggle")
		theme.mpd.update()
	end),
	awful.button({}, 3, function()
		os.execute("mpc next")
		theme.mpd.update()
	end)
))
-- /home fs
-- [[ commented because it needs Gio/Glib >= 2.54
theme.fs = lain.widget.fs({
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
--]]
-- Simple volume widget (icon + text)
local volume_icon = wibox.widget.textbox("  ")
local volume_text = wibox.widget.textbox("    ")

theme.volume = lain.widget.alsa({
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
		awful.spawn(string.format("%s -e alsamixer", terminal))
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
)) -- Weather
--[[ to be set before use
theme.weather = lain.widget.weather({
    --APPID =
    city_id = 2643743, -- placeholder (London)
    notification_preset = { font = theme.font, fg = white }
})
--]]

-- Systemtray
local systray = wibox.widget.systray()

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()
mykeyboardlayout.widget.font = theme.font
local keyboard_icon = wibox.widget.textbox(markup.font(theme.font, " 󰌌"))
local keyboardwidget = wibox.widget({
	keyboard_icon,
	mykeyboardlayout,
	layout = wibox.layout.fixed.horizontal,
})
keyboardwidget = widget_highlight(keyboardwidget, theme.colors.red)

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
	settings = function()
		widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
	end,
})

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

-- Mail IMAP check
--local mailicon = wibox.widget.texbox("  ")
--[[ commented because it needs to be set before use
mailicon:buttons(my_table.join(awful.button({ }, 1, function () awful.spawn(mail) end)))
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = ",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            widget:set_markup(markup.font(theme.font, " " .. mailcount .. " "))
            mailicon:set_image(theme.widget_mail_on)
        else
            widget:set_text("")
            mailicon:set_image(theme.widget_mail)
        end
    end
})
--]]
-- Separators
local awesome_icon = wibox.widget.textbox(markup.font("JetBrains Mono Nerd Font 15", "  "))
local arch_icon = wibox.widget.textbox(markup.font("JetBrains Mono Nerd Font 15", markup.fg.color(arch_blue, "   ")))

local function update_txt_layoutbox(s)
	-- Writes a string representation of the current layout in a textbox widget
	local txt_l = theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))] or ""
	s.mytxtlayoutbox:set_markup(markup.font(theme.font, txt_l))
end
function theme.at_screen_connect(s)
	-- Tags
	awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

	-- Create a promptbox for each screen
	--s.mypromptbox = awful.widget.prompt()

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
	-- Create battery widget
	local baticon = wibox.widget.textbox(" 󱊣 ")
	local bat = lain.widget.bat({
		full_notify = "off",
		settings = function()
			local color = theme.colors.yellow
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
			widget_highlight(wibox.container.margin(arch_icon, dpi(5), dpi(40), 0, 0)),
			mpd_widget,
			wibox.container.margin(space,dpi(60),0,0,0),
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
				keyboardwidget,
				space,
				--theme.mail.widget,
				--theme.fs.widget,
				widget_highlight(s.mytxtlayoutbox, theme.colors.purple),
				space,
				widget_highlight(volume_widget, theme.colors.green),
				space,
				widget_highlight(battery_widget, theme.colors.yellow),
				space,
				widget_highlight(clockwidget, theme.colors.blue),
				space,
				space,
			},
		},
	}) --]]
end

return theme
