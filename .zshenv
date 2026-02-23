# ~/.zshenv - loaded for ALL zsh sessions
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd)

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH=$PATH:$HOME/Scripts

export EDITOR=nvim
export SUDO_EDITOR=nvim
export BAT_THEME=ansi
. "$HOME/.cargo/env"
