#!/bin/sh

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
FD=$(command -v fd || command -v fdfind)

while true; do
  path="$("$FD" . -t f "$WALLPAPER_DIR" | sort -R | tail -n 1)"
  swaybg -i "$path" -m fill > /dev/null 2>&1 &
  SWAYBG_PID=$!
  sleep 10m
  kill "$SWAYBG_PID" > /dev/null 2>&1
done
