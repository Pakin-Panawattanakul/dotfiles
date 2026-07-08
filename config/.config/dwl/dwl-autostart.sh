#!/bin/sh

$HOME/Scripts/random-wallpaper.sh &
$HOME/Scripts/media.sh &
$HOME/Scripts/low_battery.sh &
brightnessctl set 50%
pkill -x mako
mako &
exec dbus-update-activation-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
