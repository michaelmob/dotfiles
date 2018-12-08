#!/usr/bin/env bash
case "$1" in
  post)
    setxkbmap -option caps:escape
    xset r rate 250 50
    ;;
esac
