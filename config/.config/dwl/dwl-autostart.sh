#!/bin/sh

$HOME/Scripts/random-wallpaper.sh &
$HOME/Scripts/low_battery.sh &
brightnessctl set 40%
mpc stop
touch /tmp/dwl-keymap

if [ "$HOST" = "void-linux-PC" ]; then
  wlr-randr --output DP-3 --mode 1920x1080@165Hz
elif [ "$HOST" = "void-linux" ]; then
  wlr-randr --output eDP-1 --mode 1920x1080@165Hz
fi

gammastep -l 15.87:100.99 -m wayland -b 1:0.9 &
if grep -qi "void" /etc/os-release 2>/dev/null; then
  "$HOME"/Scripts/runit-user-service.sh
  pkill -x mako
  mako &
fi
exec dbus-update-activation-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
