local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local naughty = require("naughty")

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility


-- colors scheme : Tokyonight, One-dark
local colors = require("src.assets.colors.onedark")

local theme = {}
-- Arch-specific colors
theme.arch_blue = "#1793d1" -- Arch Linux blue
theme.arch_grey = "#2f2f2f" -- dark grey

theme.default_dir = require("awful.util").get_themes_dir() .. "default"
theme.dir = os.getenv("HOME") .. "/.config/awesome/src/assets"
theme.font = "JetBrains Mono Nerd Font Propo 11"
theme.desktop_font = "JetBrains Mono Nerd Font 11"

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
theme.border_focus = theme.arch_blue .. "AA"
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
--theme.taglist_spacing = 1
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
theme.bg_systray = theme.arch_grey

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
theme.space = wibox.widget.textblock
-- Notication
--theme.notification_max_width = dpi(400)
--theme.notifiaction_max_height = dpi(80)

theme.space = wibox.widget.textbox(" ")

return theme
