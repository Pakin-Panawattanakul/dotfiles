# Path to your Oh My Zsh installation.

# if NixOS dont execute this
# ------------ Oh My Zsh ------------
if ! grep -qi "nixos" /etc/os-release 2>/dev/null; then
  export ZSH="$HOME/.oh-my-zsh"

  ENABLE_CORRECTION="false"
  COMPLETION_WAITING_DOTS="false"
  DISABLE_UNTRACKED_FILES_DIRTY="true"

  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7"

  plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
  )

  source "$ZSH/oh-my-zsh.sh"

  man() {
    command man "$@" | col -bx | bat -plman --paging=always
  }
fi

# ------------ Neovim ------------
alias vim='nvim'
alias vi='nvim'

# ------------ Fuzzy finder ------------
# Set up fzf key bindings and fuzzy completion
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"
alias -g -- fzfp="fzf --preview 'bat --color=always {}' --preview-window '~3'"

# ------------ Eza : better ls ------------
# export EZA_CONFIG_DIR="$HOME/.config/eza" # move to .zshenv
export DISABLE_LS_COLORS="true" # to show the correct theme disable LS_COLORS 
export LS_COLORS=""
alias ll='eza --color=always --long -all'
alias ls='eza --color=always'

# ------------ Zoxide: better cd------------
eval "$(zoxide init zsh --cmd cd)" #"--cmd cd" add this before zsh to remap cd to z
cd_ls(){
  cd "$@" && ls
}
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
export MANPAGER="bat -plman"
# coloriziing stuff
psg() {
    ps aux | grep --color=auto "$@" | bat -l conf
}


# ------------ Custom alias ------------
alias grep='grep --color'
alias f=fastfetch
alias dot='cd ~/dotfiles && ls -al'
alias kyber='cd $HOME/kyber'
alias lg=lazygit

# ------------ mpd alias ------------
plc() {
    fd . "$1" -E "*.spotdl" > "$HOME/Music/playlists/$1.m3u"
}

my-spotdl(){
  spotdl --cookie-file  $HOME/Downloads/cookies.txt \
    --format m4a --dont-filter-results \
    "$@"
}
alias pot-provider="cd $HOME/dotfiles/build/bgutil-ytdlp-pot-provider/server/node_modules && deno run --allow-env --allow-net --allow-ffi=. --allow-read=. ../src/main.ts"

# -----------------------------------

edp() {
  case "$1" in
    off) wlr-randr --output eDP-1 --off ;;
    on) wlr-randr --output eDP-1 --on ;;
  esac
}

#nixos
alias rebuild="sudo nixos-rebuild switch --flake ~/'dotfiles?submodules=1#'$HOST"
alias nixgc="sudo nix-collect-garbage -d"
