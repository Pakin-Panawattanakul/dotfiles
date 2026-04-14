#!/bin/sh

current_dir=$(pwd)
cd "$current_dir/dwl"
sudo make clean install

cd "$current_dir/somebar"
meson setup build
sudo ninja -C build install

cd "$current_dir/someblocks"
sudo make install
