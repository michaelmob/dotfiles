#!/usr/bin/env bash

# Default Applications
export TERMINAL='gnome-terminal'
export EDITOR='nvim'
export BROWSER='firefox'
export FM='nautilus'

# Paths
export PATH="$PATH:$HOME/.local/bin:$HOME/.scripts"

[[ -f ~/.bashrc ]] && source ~/.bashrc
