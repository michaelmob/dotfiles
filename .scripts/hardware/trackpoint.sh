#!/bin/bash
#
# /etc/udev/rules.d/10-trackpoint.rules
# ACTION=="add", SUBSYSTEM=="input", ATTR{name}=="TPPS/2 IBM TrackPoint", ATTR{device/speed}="200", ATTR{device/sensitivity}="250", ATTR{device/press_to_select}="1"

DEVICE=/sys/devices/platform/i8042/serio1

[[ -d "$DEVICE/serio2" ]] && DEVICE="$DEVICE/serio2"
[[ -z $1 ]] && SPEED=175 || SPEED=$1
[[ -z $2 ]] && SENSITIVITY=250 || SENSITIVITY=$2
[[ -z $3 ]] && PRESS=1 || PRESS=$3

echo $SPEED | sudo tee $DEVICE/speed
echo $SENSITIVITY  | sudo tee $DEVICE/sensitivity
echo $PRESS | sudo tee $DEVICE/press_to_select

exit 0
