stty -ixon
shopt -s autocd


# Environment
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
export EDITOR="vim"

PATH=$PATH:~/.gem/ruby/2.5.0/gems/jekyll-3.8.2/exe/

# Functions
bg_run() { $@ > /dev/null 2>&1 & disown ; }
bg_mpv() { bg_run mpv $1 ; exit 0; }


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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
