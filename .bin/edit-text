#!/bin/sh
sleep 0.15  # value of 0.1 does NOT work

# save current clipboard

# highlight and copy text
# note: text highlighted with keyboard does not set primary selection
target="$(xdotool getactivewindow)"
xdotool key --window "$target" ctrl+a

# create temp
temp="$(mktemp)"
trap "rm '$temp'" SIGINT EXIT

# ensure xclip worked
selection="$(xclip -o -selection primary)"

# edit
echo "$selection" > "$temp"
$TERMINAL --title float -e vim -u NONE -c 'set noswapfile' "$temp"
[[ $? != 0 ]] && notify-send 'Unable to launch editor.' && exit 1

# type text back into textbox
out="$(<$temp)"
[[ ! -z "$out" ]] && [[ "$out" != "$selection" ]] && \
  xdotool type --window "$target" --delay 0 "$out"
