#!/bin/sh

set -x 
region=$(slurp)
mkdir -p "$HOME/Pictures/screenshots"

if [ ! -z "$region" ]; then
  grim -g "$region" - | wl-copy --type image/png
  filename="$(date +%Y-%m-%d_%H-%M-%S).png"
  grim -g "$region" "$HOME/Pictures/screenshots/$filename" 
fi
