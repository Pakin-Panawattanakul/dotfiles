# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="false"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git  zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# User configuration

# ------------ Neovim ------------
alias vim='nvim'

# ------------ Fuzzy finder ------------
# Set up fzf key bindings and fuzzy completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"
alias fzf='fzf --preview "bat --color=always --style=full --line-range=:500 {}"'

# ------------ Eza : better ls ------------
# export EZA_CONFIG_DIR="$HOME/.config/eza" # move to .zshenv
alias ls='eza --color=always --long'
DISABLE_LS_COLORS="true" # to show the correct theme disable LS_COLORS 

# ------------ Zoxide: better cd------------
eval "$(zoxide init zsh --cmd cd)" #"--cmd cd" add this before zsh to remap cd to z
#cd_ls(){
#  z "$@" && ls
#}
#alias cd=cd_ls

# ------------ History ------------
HISTSIZE=3000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
#setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ------------ Starship ------------
eval "$(starship init zsh)"

# ------------ Yazi -----------------
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# os specific alias

alias cat='bat --style=plain'
# use bat for help
alias -g -- -h='-h 2>&1 | bat --language=help'
alias -g -- --help='--help 2>&1 | bat --language=help' 
export MANPAGER="bat -plman"

# ------------ Custom alias ------------
alias f=fastfetch
alias ll='ls -al'
alias dot='cd ~/dotfiles && ls -al'
alias kyber='cd $HOME/kyber'
alias ref='cd $HOME/kyber-ref/kyber768'
