#!/usr/bin/env bash

# Default Applications
export TERMINAL='konsole'
export EDITOR='nvim'
export BROWSER='firefox'
export FM='dolphin'

# Paths
export PATH="$PATH:$HOME/.local/bin:$HOME/.scripts"
export WALLPAPER_PATH="$HOME/Pictures/wallpapers"

[[ -f ~/.bashrc ]] && source ~/.bashrc
