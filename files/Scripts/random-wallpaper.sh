#!/bin/sh

WALLPAPER_DIR="$HOME/Pictures/wallpapers"

while true; do
  path="$(fd . -t f $WALLPAPER_DIR | sort -R | tail -n 1)"
  wbg -s "$path" > /dev/null 2>&1 &
  WBG_PID=$!
  sleep 10m
  kill "$WBG_PID" > /dev/null 2>&1
done
