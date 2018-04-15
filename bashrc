stty -ixon
shopt -s autocd


# Environment
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
export EDITOR="nvim"


# Functions
bg_run() { $@ > /dev/null 2>&1 & disown ; }
mpv() { bg_run gnome-mpv $1 ; exit 0; }


# Program Aliases
alias v="$EDITOR"
alias sv="sudo $EDITOR"
alias inst="sudo eopkg install"
alias rem="sudo eopkg remove"

# Service Aliases
alias weather="curl wttr.in/07653"

# Go Aliases
alias gs="cd ~/Sync"
alias gp="cd ~/Sync/Personal"
alias gw="cd ~/Sync/Workspace"
alias gc="cd ~/Sync/Personal/config"
alias it340="gw && cd school/it340"
