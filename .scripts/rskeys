#!/usr/bin/env bash
hostname="$(hostname)"

# Click modes
xmodmap -e "keycode 72 = KP_Divide"   # F6, Left click
xmodmap -e "keycode 73 = KP_Subtract" # F7, Right click
xmodmap -e "keycode 74 = KP_Multiply" # F8, Both buttons

# Laptop
if [[ "$hostname" = "x220" ]]; then
  # Movement
  xmodmap -e "keycode 166 = KP_5"   # Page left -> Click
  xmodmap -e "keycode 167 = KP_2"   # Page right -> Cursor down
  xmodmap -e "keycode 105 = Escape" # Right ctrl -> Esc

# Desktop
elif [[ "$hostname" = "pc" ]]; then
  # Movement
  xmodmap -e "keycode 112 = KP_5"       # Page up -> Click
  xmodmap -e "keycode 117 = KP_2"       # Page down -> Cursor down
  xmodmap -e "keycode 110 = KP_6"       # Home -> Cursor right
  xmodmap -e "keycode 115 = KP_8"       # End -> Cursor up
  xmodmap -e "keycode 105 = Escape"     # Right ctrl -> Esc

  # "Zoom" button on Logitech mouse becomes middle button
  xmodmap -e "pointer = 1 13 3 4 5 6 7 8 9 10 11 12 2"
fi


