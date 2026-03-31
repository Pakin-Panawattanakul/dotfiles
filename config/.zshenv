# ~/.zshenv - loaded for ALL zsh sessions
# User Directories
XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
XDG_DATA_HOME="$HOME/.local/share"
XDG_STATE_HOME="$HOME/.local/state"

# System Directories
XDG_DATA_DIRS="/usr/local/share:$HOME/.local/share/flatpak/exports/share:/usr/share:/var/lib/flatpak/exports/share"
XDG_CONFIG_DIRS="/etc/xdg"

export EDITOR=nvim
export SUDO_EDITOR=nvim
export BAT_THEME=ansi
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd)
