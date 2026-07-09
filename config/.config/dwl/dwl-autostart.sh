#!/bin/sh

$HOME/Scripts/random-wallpaper.sh &
$HOME/Scripts/low_battery.sh &
brightnessctl set 50%
pkill -x mako
mako &

"$HOME"/Scripts/runit-user-service.sh
exec dbus-update-activation-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
