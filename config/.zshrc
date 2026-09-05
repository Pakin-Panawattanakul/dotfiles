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

# ------------ Starship ------------
eval "$(starship init zsh)"

# --- bat ---
alias cat='bat --style=plain'
# use bat for help
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
# bat for man page
#export MANPAGER="bat -plman"
man() {
  command man "$@" | col -bx | bat -plman --paging=always
}

# coloriziing stuff
psg() {
    ps aux | grep --color=auto "$@" | bat -l conf
}

# ------------ Custom alias ------------
alias grep='grep --color'
alias f=fastfetch
alias dot='cd ~/nixos-dotfiles && ls -l'
alias kyber='cd $HOME/kyber'
alias lg=lazygit

# ------------ mpd alias ------------
music-sync() {
  for dir in "$HOME"/gdrive/Music/*/; do
    name="$(basename "$dir")"
    [ "$name" = "playlists" ] && continue
    fd . "$dir" -E "*.spotdl" -e mp3 | sed "s|^$HOME/gdrive/Music/||" > "$HOME/gdrive/Music/playlists/$name.m3u"
  done
  if mountpoint -q "/run/media/pakin/ECHO MINI"; then
    echo "Sync File to Snowsky"
    rsync -av --modify-window=2 --exclude "*.spotdl" --exclude "/playlists" --delete --progress ~/gdrive/Music/ "/run/media/pakin/ECHO MINI"
  fi
  #echo "Sync File to ~/Music"
  #rsync -av --exclude "*.spotdl" --delete --progress  ~/gdrive/Music/ ~/Music
}

my-spotdl(){
  spotdl --format mp3 --audio youtube-music soundcloud bandcamp \
    --max-retries 10 --dont-filter-results \
    "$@"
}
my-spotdl-with-yt() {
  echo "$1|$2"
  spotdl "$1|$2"
}
# use when don't want to check song accuracy : --dont-filter-results 
alias pot-provider="cd $HOME/nixos-dotfiles/submodules/bgutil-ytdlp-pot-provider/server/node_modules && deno run --allow-env --allow-net --allow-ffi=. --allow-read=. ../src/main.ts"

# -----------------------------------

edp() {
  case "$1" in
    off) wlr-randr --output eDP-1 --off ;;
    on) wlr-randr --output eDP-1 --on ;;
  esac
}

#nixos
alias rebuild="sudo nixos-rebuild switch --flake ~/'nixos-dotfiles?submodules=1#'$HOST"
alias nixgc="sudo nix-collect-garbage -d"
