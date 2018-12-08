#!/usr/bin/env bash
case "$1" in
  pause)
    seconds=$(( $(<"/tmp/hypersomnia-$UID.pause") - $(date +%s) ))
    duration=$(printf '%d:%02d:%02d' $((seconds/3600)) $((seconds%3600/60)) $((seconds%60)))
    notify-send -t 5000 "Hypersomnia has been paused for $duration."
    ;;
  unpause*)
    [[ "${1#*-}" = 'automatic' ]] && typeof='automatically '
    notify-send -t 5000 "Hypersomnia has been ${typeof}unpaused."
    ;;
esac
