local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local lain = require("lain")

local hotkeys_popup = require("awful.hotkeys_popup")
local mytable = awful.util.table or gears.table -- 4.{0,1} compatibility

local browser = "qutebrowser"
local modkey = "Mod4"
local altkey = "Mod1"

local keys = {}
keys.globalkeys = mytable.join(
	-- Destroy all notifications
	awful.key({ "Control" }, "space", function()
		naughty.destroy_all_notifications()
	end, { description = "destroy all notifications", group = "hotkeys" }),
	--[[ Take a screenshot
	-- https://github.com/lcpz/dots/blob/master/bin/screenshot
	awful.key({ altkey }, "p", function()
		os.execute("screenshot")
	end, { description = "take a screenshot", group = "hotkeys" }),

	-- [[ X screen locker
	awful.key({ altkey, "Control" }, "l", function()
		os.execute(scrlocker)
	end, { description = "lock screen", group = "hotkeys" }),
	--]]

	-- toggle between force tiling to fix not properlly tile clients

	--[[
  awful.key({ modkey, "Control", "Shift" }, "r", function()
    awful.spawn.with_shell("~/Templates/scripts/force_tile.sh")
    awesome.restart()
  end, { description = "reload awesome", group = "awesome" }),
  --]]
	-- Show help
	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	-- Tag browsing
	awful.key({ modkey, "Control" }, "h", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey, "Control" }, "l", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey, "Control" }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey, "Control" }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	--awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
	awful.key({ modkey, "Shift" }, "r", function()
		lain.util.rename_tag()
	end, { description = "rename tag", group = "tag" }),
  --[[
	-- Non-empty tag browsing
	awful.key({ modkey }, "k", function()
		lain.util.tag_view_nonempty(-1)
	end, { description = "view  previous nonempty", group = "tag" }),
	awful.key({ modkey }, "j", function()
		lain.util.tag_view_nonempty(1)
	end, { description = "view  previous nonempty", group = "tag" }),

	-- Default client focus
	awful.key({ altkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ altkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),
	--]]
	-- [[ By-direction client focus
	awful.key({ modkey }, "j", function()
		awful.client.focus.global_bydirection("down")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus down", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.global_bydirection("up")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus up", group = "client" }),
	awful.key({ modkey }, "h", function()
		awful.client.focus.global_bydirection("left")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus left", group = "client" }),
	awful.key({ modkey }, "l", function()
		awful.client.focus.global_bydirection("right")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus right", group = "client" }),
	--]]
	-- Menu
	awful.key({ modkey }, "w", function()
		awful.util.mymainmenu:show()
	end, { description = "show main menu", group = "awesome" }),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
	--[[ awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),
  --]]

	-- On-the-fly useless gaps change
	awful.key({ altkey }, "=", function()
		lain.util.useless_gaps_resize(1)
	end, { description = "increment useless gaps", group = "layout" }),
	awful.key({ altkey }, "-", function()
		lain.util.useless_gaps_resize(-1)
	end, { description = "decrement useless gaps", group = "layout" }),

	-- Show/hide wibox
	awful.key({ modkey, "Control" }, "b", function()
		for s in screen do
			s.mywibar.visible = not s.mywibar.visible
		end
	end, { description = "toggle wibox", group = "awesome" }),

	-- Standard program
	awful.key({ modkey }, "t", function()
		awful.spawn(awful.util.terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, altkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "q", function()
		local rofi_path = os.getenv("HOME") .. "/.config/rofi/scripts/powermenu_t4"
		awful.util.spawn(rofi_path)
	end, { description = "Power menu", group = "awesome" }),

	awful.key({ altkey }, "j", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),

	awful.key({ altkey }, "k", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),

	awful.key({ altkey, "Control" }, "j", function()
		awful.tag.incnmaster(1, nil, tostring)
	end, { description = "increase the number of master clients", group = "layout" }),

	awful.key({ altkey, "Control" }, "k", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),

	awful.key({ altkey, "Shift" }, "j", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),

	awful.key({ altkey, "Shift" }, "k", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),

	awful.key({ modkey }, "Tab", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),

	awful.key({ modkey, "Shift" }, "Tab", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	awful.key({ modkey, "Shift" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	--[[ Dropdown application
	awful.key({ modkey }, "z", function()
		awful.screen.focused().quake:toggle()
	end, { description = "dropdown application", group = "launcher" }),
	--]]

	-- Widgets popups
	awful.key({ altkey }, "c", function()
		if beautiful.cal then
			beautiful.cal.show(7)
		end
	end, { description = "show calendar", group = "widgets" }),
	--[[
	awful.key({ altkey }, "h", function()
		if beautiful.fs then
			beautiful.fs.show(7)
		end
	end, { description = "show filesystem", group = "widgets" }),
	awful.key({ altkey }, "w", function()
		if beautiful.weather then
			beautiful.weather.show(7)
		end
	end, { description = "show weather", group = "widgets" }),
	--]]
	-- Screen brightness
	awful.key({}, "XF86MonBrightnessUp", function()
		os.execute("brightnessctl set 10%+ ")
	end, { description = "backlight +10%", group = "hotkeys" }),
	awful.key({}, "XF86MonBrightnessDown", function()
		os.execute("brightnessctl set 10%-")
	end, { description = "backlight -10%", group = "hotkeys" }),
	--]]
	-- ALSA volume control
	awful.key({ "Any" }, "XF86AudioRaiseVolume", function()
		os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel, awful.util.terminal))
		beautiful.volume.update()
	end, { description = "volume up", group = "hotkeys" }),

	awful.key({ "Any" }, "XF86AudioLowerVolume", function()
		os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
		beautiful.volume.update()
	end, { description = "volume down", group = "hotkeys" }),

	awful.key({ "Any" }, "XF86AudioMute", function()
		os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
		beautiful.volume.update()
	end, { description = "toggle mute", group = "hotkeys" }),

	awful.key({ altkey, "Control" }, "m", function()
		os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
		beautiful.volume.update()
	end, { description = "volume 100%", group = "hotkeys" }),

	awful.key({ altkey, "Control" }, "0", function()
		os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
		beautiful.volume.update()
	end, { description = "volume 0%", group = "hotkeys" }),

	-- MPD control
	awful.key({ "Any" }, "XF86AudioPlay", function()
		os.execute("mpc toggle")
		beautiful.mpd.update()
	end, { description = "mpc toggle", group = "widgets" }),
	awful.key({ "Any" }, "XF86AudioPrev", function()
		os.execute("mpc prev")
		beautiful.mpd.update()
	end, { description = "mpc prev", group = "widgets" }),

	awful.key({ "Any" }, "XF86AudioNext", function()
		os.execute("mpc next")
		beautiful.mpd.update()
	end, { description = "mpc next", group = "widgets" }),

	awful.key({ "Shift" }, "XF86AudioRaiseVolume", function()
		os.execute("mpc volume +5")
		os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
		beautiful.volume.update()
	end, { description = "volume up", group = "hotkeys" }),

	awful.key({ "Shift" }, "XF86AudioLowerVolume", function()
		os.execute("mpc volume -5")
		os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
		beautiful.volume.update()
	end, { description = "volume down", group = "hotkeys" }),

	--[[ Copy primary to clipboard (terminals to gtk)
	awful.key({ modkey }, "c", function()
		awful.spawn.with_shell("xsel | xsel -i -b")
	end, { description = "copy terminal to gtk", group = "hotkeys" }),
	-- Copy clipboard to primary (gtk to terminals)
	awful.key({ modkey }, "v", function()
		awful.spawn.with_shell("xsel -b | xsel")
	end, { description = "copy gtk to terminal", group = "hotkeys" }),
	--]]

	-- User programs

	-- Default
	--[[ Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
    --]]
	--[[ dmenu
    awful.key({ modkey }, "x", function ()
            os.execute(string.format("dmenu_run -i -fn 'Monospace' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
            beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
        end,
        {description = "show dmenu", group = "launcher"}),
    --]]
	-- alternatively use rofi, a dmenu-like application with more features
	-- check https://github.com/DaveDavenport/rofi for more details
	--[[ rofi
    awful.key({ modkey }, "x", function ()
            os.execute(string.format("rofi -show %s -theme %s",
            'run', 'dmenu'))
        end,
        {description = "show rofi", group = "launcher"}),
    --]]

	-- File manager 
	awful.key({ modkey }, "e", function()
		awful.util.spawn("nemo")
	end, { description = "file manager", group = "launcher" }),
	--
	--	local rofi_path = strig.format("%s/.config/rofi/luanchers/type-2/luancher.sh",os.getenv("HOME"))
	--
	-- Rofi launcher
	awful.key({ modkey }, "r", function()
		local rofi_path = os.getenv("HOME") .. "/.config/rofi/scripts/launcher_t3"
		awful.util.spawn(rofi_path)
	end, { description = "App launcher", group = "launcher" }),

	-- Rofi open windows
	awful.key({ altkey }, "Tab", function()
		awful.util.spawn("rofi -show window")
	end, { description = "List open applications", group = "launcher" }),

	-- Browser
	awful.key({ modkey }, "b", function()
		awful.util.spawn(browser)
	end, { description = browser, group = "launcher" }),

	--Discord
	awful.key({ modkey }, "d", function()
		awful.util.spawn("discord")
		awful.tag.find_by_name(awful.screen.focused(), "  "):view_only()
	end, { description = "open discord", group = "launcher" }),

	-- Music player rmpc
	awful.key({ altkey }, "m", function()
		local music_tag = awful.tag.find_by_name(awful.screen.focused(), " 󰝚 ")
		if music_tag then
			local clients = music_tag:clients()
			local spawn = true
			for _, client in ipairs(clients) do
				if client.music_instant == true then
					spawn = false
					break
				end
			end
			if spawn then
				awful.util.spawn("ghostty -e rmpc", { tag = " 󰝚 ", music_instant = true })
			end
			music_tag:view_only()
		end
	end, { description = "open rmpc", group = "launcher" }),
	-- flameshot
	awful.key({ "Any" }, "Print", function()
		awful.util.spawn("flameshot gui")
	end, { description = "flameshot", group = "launcher" })

	--[[
	awful.key({ modkey }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" })
	--]]
)

keys.clientkeys = mytable.join(
	--awful.key({ altkey, "Shift" }, "m", lain.util.magnify_client, { description = "magnify client", group = "client" }),
	awful.key({ modkey }, "F11", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),

	awful.key({ altkey }, "F4", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key({ modkey }, "q", function(c)
		c:kill()
	end, {}),

	awful.key({ modkey }, "f", awful.client.floating.toggle, { description = "toggle floating", group = "client" }),
	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	--[[awful.key({ modkey }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),
	--]]
	awful.key({ modkey }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),

	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" })
	--[[
	awful.key({ modkey, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),
	awful.key({ modkey, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" })
    ]]
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 8 do
	keys.globalkeys = mytable.join(
		keys.globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
					local screen = awful.screen.focused()
					local tag2 = screen.tags[i]
					tag2:view_only()
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

return keys
