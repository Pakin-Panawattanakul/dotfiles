#! /bin/sh

pkill --exact mpd
sleep 1
exec mpd
