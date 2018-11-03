stty -ixon
shopt -s autocd

# Colors
(cat ~/.cache/wal/sequences &)

# Local Variables
TERM=xterm-256color


# Environment Variables
export LANG='en_US.UTF-8'
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

# Bindings
# bind '"\e[P": delete-char'
# bind '"\C-h": backward-word'
# bind '"\C-l": forward-word'

# FZF
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# Functions
ranger() { ~/.scripts/ranger $@ ; }
cd() { builtin cd "$@" && pwd > ~/.last_dir ; }
L() { builtin cd "$(< ~/.last_dir)" ; }
S() { cd . ; }

# Aliases
alias resource='source ~/.bashrc'

alias :q='exit'
alias vim="$EDITOR"
alias v="$EDITOR"
alias r='ranger'
alias s='sudo'
alias ls='ls --color=auto'
alias clip='xclip -selection c'

alias weather='curl wttr.in/07653'
