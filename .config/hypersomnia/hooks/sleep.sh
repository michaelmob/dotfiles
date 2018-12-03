#!/usr/bin/env bash
case "$1" in
  post)
    sleep 1
    setxkbmap -option caps:escape
    xset r rate 250 50
    ;;
esac
