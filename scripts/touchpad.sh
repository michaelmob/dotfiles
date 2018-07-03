#!/usr/bin/env bash
ID=$(xinput | grep -oP 'TouchPad.*?id=\K.*?\w+')
OPTION="${1:-toggle}"

# Toggle TouchPad
if [[ $OPTION = 'toggle' ]]; then
  enabled=$(xinput list-props $ID | grep -oP 'Device Enabled.*:\s\K[0-1]$')
  [[ "$enabled" = "0" ]] && OPTION='enable' || OPTION='disable'
fi

# Show notification
[[ $2 = '-q' ]] || notify-send -a 'TouchPad' -t 1000 "TouchPad is ${OPTION}d."
xinput $OPTION $ID
