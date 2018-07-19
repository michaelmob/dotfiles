stty -ixon
shopt -s autocd

# Colors
(cat ~/.cache/wal/sequences &)

# Environment
export LANG="en_US.UTF-8"
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
TERM=xterm-256color

# Functions
ranger() { [[ -z "$RANGER_LEVEL" ]] && ~/.scripts/ranger.sh || exit; }

# Program Aliases
alias v="$EDITOR"
alias sv="sudo $EDITOR"
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias ranger="~/.scripts/ranger.sh"

# Service Aliases
alias weather="curl wttr.in/07653"

# Go Aliases
alias gs="cd ~/Sync"
alias gp="cd ~/Sync/Personal"
alias gw="cd ~/Sync/Workspace"
alias gc="cd ~/Sync/Config"

[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
