# ~/.zshenv - loaded for ALL zsh sessions
#export PATH="$PATH:$HOME/.local/bin"
#export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
#export PATH="$PATH:$HOME/scripts"

export EDITOR=nvim
export SUDO_EDITOR=nvim
export BAT_THEME=ansi
export MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | batcat -p -lman'"
