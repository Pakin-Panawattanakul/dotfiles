#! /bin/sh

# start mpd if not already start
if [ ! $(pgrep mpd) ]; then
  exec mpd
fi
