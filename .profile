#!/usr/bin/env bash
[[ "$XDG_CURRENT_DESKTOP" = 'KDE' ]] || [[ "$XDG_CURRENT_DESKTOP" = 'GNOME' ]] || export QT_QPA_PLATFORMTHEME='qt5ct'

export PATH="$PATH:$HOME/.scripts"
export TERMINAL='st'
export EDITOR='vim'
export BROWSER='firefox'

[[ -f ~/.bashrc ]] && source ~/.bashrc

# Lockscreen
export IDLELOCK_NOTIFY_SECONDS=60
export IDLELOCK_LOCK_SECONDS=300
export IDLELOCK_SCREEN_OFF_SECONDS=+10
export IDLELOCK_SUSPEND_SECONDS=600
export IDLELOCK_LOCK_COMMAND='besterlockscreen -l dim'

export IDLELOCK_BATTERY_NOTIFY_SECONDS=60
export IDLELOCK_BATTERY_LOCK_SECONDS=120
export IDLELOCK_BATTERY_SCREEN_OFF_SECONDS=10
export IDLELOCK_SUSPEND_SECONDS=300
