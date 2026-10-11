#!/bin/sh
# Lock the screen with a random wallpaper as the background (swaylock).
# Replaces waylock; LOCK_*_COLOR are swaylock-format (rrggbb, no 0x prefix).
WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/wallpapers}"
FD=$(command -v fd || command -v fdfind)

img=""
if [ -d "$WALLPAPER_DIR" ] && [ -n "$FD" ]; then
  img="$("$FD" . -t f "$WALLPAPER_DIR" | sort -R | tail -n 1)"
fi

if [ -n "$img" ]; then
  exec swaylock -e -F -i "$img" -s fill \
    --inside-color       "${LOCK_INIT_COLOR:-282727}" \
    --inside-ver-color   "${LOCK_INPUT_COLOR:-2b3328}" \
    --inside-wrong-color "${LOCK_FAIL_COLOR:-43242b}" "$@"
else
  exec swaylock -e -F -c "${LOCK_INIT_COLOR:-282727}" \
    --inside-ver-color   "${LOCK_INPUT_COLOR:-2b3328}" \
    --inside-wrong-color "${LOCK_FAIL_COLOR:-43242b}" "$@"
fi
