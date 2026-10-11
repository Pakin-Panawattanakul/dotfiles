#/bin/sh
stow config
stow files

submodules_dir="$HOME/dotfiles/submodules"
config_dir="$HOME/dotfiles/config"

mkdir -p ~/.local/bin
ln -sf "$submodules_dir"/wmenu-scripts/wmenu-drun ~/.local/bin
ln -sf "$submodules_dir"/wmenu-scripts/wmenu-powermenu ~/.local/bin
ln -sf "$submodules_dir"/wmenu-scripts/wmenu-screenshot ~/.local/bin

ln -sf "$config_dir"/.config/dwl/config.h "$submodules_dir"/dwl
ln -sf "$config_dir"/.config/dwl/blocks.h "$submodules_dir"/someblocks
ln -sf "$config_dir"/.config/dwl/start-dwl ~/.local/bin
