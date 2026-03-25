#!/bin/sh

# stowing config and asset dir
stow assets
stow config
stow wmenu-scripts --target="$HOME/.local/bin" 
