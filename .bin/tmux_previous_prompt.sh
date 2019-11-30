#!/usr/bin/env bash
# github.com/thetarkus

# bind-key -T copy-mode-vi 'P' run-shell -b "bash ~/.bin/tmux_previous_prompt.sh"

pane_height=$(tmux display-message -p '#{pane_height}')
pane_contents=$(tmux capture-pane -pS -5000 | tac)
prompt_char="${PROMPT_CHAR:-λ}"
IFS=$'\n' \
    occurences=($(LC_ALL=C grep -n "$prompt_char" -m 2 <<< "$pane_contents"))

tmux copy-mode \; \
    send-keys -X goto-line $(( ${occurences[1]%%:*} - pane_height))
