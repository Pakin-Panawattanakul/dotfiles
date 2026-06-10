#!/bin/sh
# ~/.config/sway/scripts/toggle-layout.sh

current=$(swaymsg -t get_tree | jq '.. | select(.type? == "workspace" and .focused? == true) | .layout')

if [ "$current" = '"tabbed"' ]; then
    swaymsg layout split
else
    swaymsg layout tabbed
fi
