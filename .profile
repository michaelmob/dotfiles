#!/usr/bin/env bash
[[ "$XDG_CURRENT_DESKTOP" = "KDE" ]] || [[ "$XDG_CURRENT_DESKTOP" = "GNOME" ]] || export QT_QPA_PLATFORMTHEME="qt5ct"

export PATH="$PATH:$HOME/.scripts"
export TERMINAL="st"
export EDITOR="nvim"
export BROWSER="firefox"

[[ -f ~/.bashrc ]] && source ~/.bashrc

hostname="$(hostname)"

# Desktop
if [[ $hostname = "pc" ]]; then
  export NOTIFY_SECONDS=60
  export LOCK_MINUTES=10
  export SUSPEND_MINUTES=5

# Laptop, probably
else
  export NOTIFY_SECONDS=30
  export LOCK_MINUTES=5
  export SUSPEND_MINUTES=5
fi
