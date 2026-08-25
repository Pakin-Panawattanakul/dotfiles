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
-- Weather
-- need to be set before use
local weather = lain.widget.weather({
    --APPID =
    city_id = 2643743, -- placeholder (London)
    notification_preset = { font = theme.font, fg = theme.colors.white }
})
return weather
