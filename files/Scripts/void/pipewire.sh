#! /bin/sh

pkill --exact pipewire
sleep 1
exec pipewire
