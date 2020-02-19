#!/usr/bin/env bash

# Ensure session is interactive
  # if [[ ! -z "$DISPLAY" ]] && [[ -z "$TMUX" ]] && [[ $- =~ i ]]; then
  #   echo $$
  # fi
/usr/bin/tmux $@ &
sessions=$(tmux list-sessions -F '#{session_created}|#{session_id}')

for session_created in ${sessions[@]}; do
  num=${session_created%|*}
  (( num > max )) && max=$num && session_id=${session_created#*|}
done

echo 'Session ID: ' $session_id
fg
