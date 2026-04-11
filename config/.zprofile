#nvidia
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia

# User Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# System Directories
export XDG_DATA_DIRS="/usr/local/share:$HOME/.local/share/flatpak/exports/share:/usr/share:/var/lib/flatpak/exports/share"
export XDG_CONFIG_DIRS="/etc/xdg"

export SWAY_ROFI_SCREENSHOT_SAVEDIR="$HOME/Pictures/screenshots"
export PATH="$HOME/.local/bin:$PATH:$HOME/.cargo/bin"
