#!/usr/bin/env bash
cycle=$(xset q | grep -oP "cycle:\s+\K[0-9]+")
((cycle > 0)) && notify-send -t 5000 -a "Screensaver" "Lockscreen will be activated in $cycle seconds."
#bash /usr/share/doc/xss-lock/dim-screen.sh
