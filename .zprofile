#!/usr/bin/env zsh

# Default Applications
export TERMINAL='gnome-terminal'
export EDITOR='nvim'
export BROWSER='firefox'
export FM='nautilus'

# Paths
export PATH="$PATH:$HOME/.local/bin:$HOME/.scripts"

[[ -f ~/.zshrc ]] && source ~/.zshrc
