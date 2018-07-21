#!/usr/bin/env bash
# Run instance of a scratchpad
xdotool search --class "$1" || $TERMINAL -c "$1" -e bash -c "while true; do $2; done"
