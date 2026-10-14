#!/bin/sh

lock=/tmp/screenshot.lock

if ! mkdir "$lock" 2>/dev/null; then
    exit 0
fi

trap 'rmdir "$lock"' EXIT
trap 'exit 1' HUP INT TERM

region=$(slurp) || exit 1
[ -n "$region" ] || exit 0

mkdir -p "$HOME/Pictures/screenshots" || exit 1

grim -g "$region" - | wl-copy --type image/png

filename="$(date +%Y-%m-%d_%H-%M-%S).png"
grim -g "$region" "$HOME/Pictures/screenshots/$filename"
