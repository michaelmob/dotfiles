#!/usr/bin/env bash
usage() {
  echo "Inactivity Screensaver with i3lock-fancy"
  echo "Required Packages: i3lock-fancy, xss-lock, xidlehook"
  echo
  echo "Usage:"
  echo "    $0 -l 3 -o 2 -d 60 -s 5"
  echo
  echo "Optional Args:"
  echo "    -l <lock_minutes>       Minutes before lockscreen is displayed"
  echo "    -o <screen_off_minutes> Minutes before screen turns off"
  echo "    -d <dim_seconds>        Seconds to dim before screen turns off"
  echo "    -s <suspend_minutes>    Minutes before suspending system"
  echo "    -X                      Do not lock screen before suspending"
  echo
  echo "Set any optional argument to zero (0) to disable it"
}

# Variables
LOCK_MINUTES=3
SCREEN_OFF_MINUTES=2
DIM_SECONDS=60
SUSPEND_MINUTES=5
LOCK_BEFORE_SUSPEND=true
PID_FILE=/tmp/screensaver_pid

# Delete pid file on exit
trap "rm $PID_FILE" EXIT

# Options
while getopts "hl:o:d:s:X" arg; do
  case "$arg" in
    h) usage; exit 1 ;;
    l) LOCK_MINUTES=$OPTARG ;;
    o) SCREEN_OFF_MINUTES=$OPTARG ;;
    d) DIM_SECONDS=$OPTARG ;;
    s) SUSPEND_MINUTES=$OPTARG ;;
    X) LOCK_BEFORE_SUSPEND=false ;;
  esac
done


#
# Functions
#

# Echo function contents
func() { echo $(declare -f $1) | grep -oP "(.*?){\K(.*)(?=\})" ; }

# Lock screen when locker is not running
lock() {
  [[ -z "$(pgrep -x i3lock)" ]] && i3lock-fancy
}

# Dim screen to 10%
dim() {
  xbacklight -get > /tmp/screen_brightness
  xbacklight -set 10
}

# Undim screen to previous brightness
undim() {
  [[ ! -f /tmp/screen_brightness ]] && return
  xbacklight -set $(cat /tmp/screen_brightness)
  rm /tmp/screen_brightness
}

# Turn screen off
screen_off() {
  locked="$(pgrep -x i3lock)"
  xset dpms force off

  # Do not kill i3lock if it was already open
  [[ -n $locked ]] && return 0

  # Attempt to kill i3lock for 10 seconds after screen turns off
  for in in {1..100}; do
    sleep 0.1
    pkill i3lock && break
  done
}

# Suspend machine
suspend_machine() {
  systemctl suspend
  sleep 2 && xset dpms force on
}


#
# Timers
#

# Kill previous processes
[[ -f $PID_FILE ]] && while read pid; do kill -9 $pid; done < $PID_FILE
rm -f $PID_FILE; touch $PID_FILE; sleep 1

# Screen Locker
if [[ $LOCK_BEFORE_SUSPEND = true ]]; then
  xss-lock -- sh -c "$(func lock)" & echo $! >> $PID_FILE
fi

if (( $LOCK_MINUTES > 0 )); then 
  xidlehook \
    --time $LOCK_MINUTES \
    --timer "$(func lock)" \
    --not-when-audio \
    --not-when-fullscreen & echo $! >> $PID_FILE
fi

# Screen Off
if (( $SCREEN_OFF_MINUTES > 0 )); then 
  xidlehook \
    --time $SCREEN_OFF_MINUTES \
    --timer "$(func screen_off); $(func undim)" \
    --notify $DIM_SECONDS \
    --notifier "$(func dim)" \
    --canceller "$(func undim)" \
    --not-when-audio \
    --not-when-fullscreen & echo $! >> $PID_FILE
fi

# Suspend
if (( $SUSPEND_MINUTES > 0 )); then
  xidlehook \
    --time $SUSPEND_MINUTES \
    --timer "$(func suspend_machine)" \
    --not-when-audio \
    --not-when-fullscreen & echo $! >> $PID_FILE
fi

wait
