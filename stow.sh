#/bin/sh
stow config
stow files

submodules_dir="$HOME/dotfiles/submodules"
config_dir="$HOME/dotfiles/config"

mkdir -p ~/.local/bin
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/pixmaps

ln -sf "$submodules_dir"/wmenu-scripts/wmenu-drun ~/.local/bin
ln -sf "$submodules_dir"/wmenu-scripts/wmenu-powermenu ~/.local/bin
ln -sf "$submodules_dir"/wmenu-scripts/wmenu-screenshot ~/.local/bin
ln -sf "$submodules_dir"/wmenu-scripts/wmenu-tlpctl ~/.local/bin

# ZSA keymap
ln -sf "$HOME"/dotfiles/zsa/keymapp ~/.local/bin
ln -sf "$HOME"/dotfiles/zsa/keymapp.desktop ~/.local/share/applications/
ln -sf "$HOME"/dotfiles/zsa/icon.png ~/.local/share/pixmaps/keymapp.png
