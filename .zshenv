# ~/.zshenv - loaded for ALL zsh sessions

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH=$PATH:$HOME/Scripts
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
