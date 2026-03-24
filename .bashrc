# ~/.bashrc

alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# ------------ Neovim ------------
alias vim='nvim'

# ------------ Starship ------------
eval "$(starship init bash)"

# ------------ Fuzzy finder ------------
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
alias fzf='fzf --preview "batcat --color=always --style=full --line-range=:500 {}"'

# ------------ Yazi -----------------
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

alias cat='bat --style=plain'
# use bat for help
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}
export manpager="sh -c 'awk '\''{ gsub(/\x1b\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"

# ------------ Eza : better ls ------------
# export EZA_CONFIG_DIR="$HOME/.config/eza" # move to .zshenv
alias ls='eza --color=always --long'
DISABLE_LS_COLORS="true" # to show the correct theme disable LS_COLORS 

# ------------ History ------------
export HISTCONTROL="erasedups:ignorespace"

# cd when enter just directory name
shopt -s autocd

# ------------ Custom alias ------------
alias f=fastfetch
alias ll='ls -al'
alias dot='cd ~/dotfiles && ls -al'
alias kyber='cd $HOME/kyber'
alias ref='cd $HOME/kyber-ref/kyber768'
[[ ! ${BLE_VERSION-} ]] || ble-attach

# ENV variable
export PATH="$PATH:$HOME/.local/bin"
export PATH=$PATH:$HOME/Scripts
export WMENU_OPTIONS="-N 07080b \
        -n e0e2ea \
        -M b3f6c0 \
        -m 07080b \
        -s 07080b \
        -S 7edfde \
        -f 'JetBrainsMonoNerdFontPropo Regular 11'"

export EDITOR=nvim
export SUDO_EDITOR=nvim
export BAT_THEME=ansi

