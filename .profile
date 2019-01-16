#!/usr/bin/env bash
[[ 'KDE GNOME' == *"$XDG_CURRENT_DESKTOP"* ]] || \
	export QT_QPA_PLATFORMTHEME='qt5ct'

# Default Applications
export TERMINAL='st'
export EDITOR='vim'
export BROWSER='brave'
export FM='pcmanfm-qt'

# Paths
export PATH="$PATH:$HOME/.local/bin:$HOME/.scripts"
export WALLPAPER_PATH="$HOME/Pictures/wallpapers"

[[ -f ~/.bashrc ]] && source ~/.bashrc
