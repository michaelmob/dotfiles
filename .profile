#!/usr/bin/env bash
[[ 'KDE GNOME' == *"$XDG_CURRENT_DESKTOP"* ]] || \
	export QT_QPA_PLATFORMTHEME='qt5ct'

export PATH="$PATH:$HOME/.local/bin:$HOME/.scripts"
export TERMINAL='st'
export EDITOR='vim'
export BROWSER='brave'
export FM='pcmanfm-qt'

[[ -f ~/.bashrc ]] && source ~/.bashrc
