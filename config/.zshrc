# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="false"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git  zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# User configuration
# auto suggestion color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7"

# ------------ Neovim ------------
alias vim='nvim'
alias vi='nvim'

# ------------ Fuzzy finder ------------
# Set up fzf key bindings and fuzzy completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"
alias -g -- fzfp="fzf --preview 'bat --color=always {}' --preview-window '~3'"

# ------------ Eza : better ls ------------
# export EZA_CONFIG_DIR="$HOME/.config/eza" # move to .zshenv
export DISABLE_LS_COLORS="true" # to show the correct theme disable LS_COLORS 
export LS_COLORS=""
alias ll='eza --color=always --long'
alias ls='eza --color=always'

# ------------ Zoxide: better cd------------
eval "$(zoxide init zsh --cmd cd)" #"--cmd cd" add this before zsh to remap cd to z
cd_ls(){
  cd "$@" && ls
}
alias cd=cd_ls

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

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

# ------------ Starship ------------
eval "$(starship init zsh)"

# --- bat ---
alias cat='bat --style=plain'
# use bat for help
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
# bat for man page
man() {
  command man "$@" | col -bx | bat -plman --paging=always
}
# coloriziing stuff
alias psg='ps aux | bat -l conf | grep $@'


# ------------ Custom alias ------------
alias grep='grep --color'
alias f=fastfetch
alias ll='ls -al'
alias dot='cd ~/.dotfiles && ls -al'
alias kyber='cd $HOME/kyber'

# void linux
alias xqr='xbps-query -Rs'
