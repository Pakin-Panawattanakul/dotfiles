# ~/.zshenv - loaded for ALL zsh sessions
# User Directories
XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
XDG_DATA_HOME="$HOME/.local/share"
XDG_STATE_HOME="$HOME/.local/state"

# System Directories
XDG_DATA_DIRS="/usr/local/share:$HOME/.local/share/flatpak/exports/share:/usr/share:/var/lib/flatpak/exports/share"
XDG_CONFIG_DIRS="/etc/xdg"

export WMENU_OPTIONS=" -i -b \
        -N 07080b \
        -n e0e2ea \
        -M b3f6c0 \
        -m 07080b \
        -s 07080b \
        -S 7edfde \
        -f 'JetBrainsMonoNerdFontPropo Regular 11'"

export EDITOR=nvim
export SUDO_EDITOR=nvim
export BAT_THEME=ansi
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd)

#export WL_PRESENT_DMENU="wmenu $WMENU_OPTIONS"
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia

export QT_QPA_PLATFORM=wayland
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
. "$HOME/.cargo/env"
