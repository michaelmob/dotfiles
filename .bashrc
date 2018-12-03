stty -ixon
shopt -s autocd

# Colors
(cat $HOME/.config/wpg/sequences &)

# Local Variables


# Environment Variables
export TERM='xterm-256color'
export HISTCONTROL='ignoreboth'
export LANG='en_US.UTF-8'
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

# FZF
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# Functions
ranger() { ~/.scripts/ranger $@ ; }
cd() { builtin cd "$@" && pwd > ~/.last-dir ; }
L() { builtin cd "$(< ~/.last-dir)" ; }
S() { pwd > ~/.last-dir ; }

# Aliases
alias :q='exit'
alias so='source ~/.bashrc'
alias vim="$EDITOR"
alias v="$EDITOR"
alias r='ranger'
alias s='sudo'
alias t='~/.scripts/tmux'
alias g='. ~/.scripts/save-dir'
alias ls='ls --color=auto --group-directories-first'
alias xclip='xclip -selection c'
alias weather='curl wttr.in/07653'
alias gdb='gdb -q'

# Git Aliases
alias gs='git status -uno'
alias gd='git diff HEAD'
alias gc='git commit'
alias gu='git add -u'
