#!/bin/bash

_ps="mako swaybg gammastep"
for _prs in $_ps; do
  if [ "$(pidof "$_prs")" ]; then
      killall -9 "${_prs}"
  fi
done

# Start up applications
#swaybg --output '*' --image "$HOME/Pictures/wallpapers/cosmic/orion_nebula_nasa_heic0601a.jpg" &
wbg "$HOME/Pictures/wallpapers/cosmic/orion_nebula_nasa_heic0601a.jpg" &
mako &
gammastep -l 36:138 &
"$HOME/Scripts/low_battery.sh" &

wallpaper="$HOME/Pictures/wallpapers/cosmic/orion_nebula_nasa_heic0601a.jpg"
swayidle -w \
         timeout 600 "swaylock -f -i $wallpaper" \
         timeout 900 "systemctl suspend" \
         before-sleep "swaylock -f -i $wallpaper" &

for portal in xdg-desktop-portal-wlr xdg-desktop-portal; do
   pkill -e "$portal"
done

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots

# Start xdg-desktop-portal-wlr
/usr/lib/xdg-desktop-portal-wlr &

# Start main xdg-desktop-portal
/usr/lib/xdg-desktop-portal &

# Polkit agent (check if available)
if [ -x "/usr/lib/xfce-polkit/xfce-polkit" ]; then
    /usr/lib/xfce-polkit/xfce-polkit &
fi

wlr-randr --output HDMI-A-1 --mode 2560x1440
