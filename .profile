#!/usr/bin/env bash
[[ "$XDG_CURRENT_DESKTOP" = "KDE" ]] || [[ "$XDG_CURRENT_DESKTOP" = "GNOME" ]] || export QT_QPA_PLATFORMTHEME="qt5ct"

export PATH="$PATH:$HOME/.scripts"
export TERMINAL="st"
export EDITOR="nvim"
export BROWSER="firefox"

[[ -f ~/.bashrc ]] && source ~/.bashrc
