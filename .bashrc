stty -ixon
set -o vi
shopt -s autocd

# Colors
(cat ~/.cache/wal/sequences &)

# Environment
export LANG="en_US.UTF-8"
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
TERM=xterm-256color

# Binds
bind '"\C-o": operate-and-get-next'
bind '"\C-n": next-history'
bind '"\C-p": previous-history'
bind '"\C-j": next-history'
bind '"\C-k": previous-history'
bind '"\C-l": clear-screen'
bind '"\e[1;5C": forward-word'
bind '"\e[1;5D": backward-word'

# FZF
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# Functions
ranger() { [[ -z $RANGER_LEVEL ]] && ~/.scripts/run.sh /usr/bin/ranger || exit ; }
cd() { builtin cd $@ && pwd > ~/.last_dir ; }
ld() { builtin cd $(< ~/.last_dir) ; }

# Aliases
alias resource="source ~/.bashrc"

alias q="exit"
alias :q="exit"
alias v="$EDITOR"
alias r="ranger"
alias s="sudo"
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"

alias weather="curl wttr.in/07653"
