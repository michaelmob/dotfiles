stty -ixon
shopt -s autocd
shopt -s histappend

# Blur
if [[ $(ps --no-header -p $PPID -o comm) =~ yakuake|alacritty|kitty ]]; then
  for wid in $(xdotool search --pid $PPID); do
    xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $wid
  done
fi

# FZF
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# Functions
ifind() { find . -iname "*$@*" 2> /dev/null ; }
cd() { builtin cd "$@" && pwd > ~/.previous-dir ; }
L() { builtin cd "$(<~/.previous-dir)" ; }

# General aliases
alias :q='exit'

# Program aliases
alias vim="$EDITOR"
alias ls='ls --color=auto --group-directories-first'
alias xclip='xclip -selection c'
alias nvimc="nvim $HOME/.config/nvim/init.vim"

# Git aliases
alias gs='git status -uno'
alias gd='git diff HEAD'
alias gc='git commit'
alias gu='git add -u'

# Environment variables
export HISTCONTROL='ignoreboth:ignoredups:erasedups'
export PATH="$PATH:$HOME/.scripts:$HOME/.bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
export TERM='xterm-256color'
export LANG='en_US.UTF-8'
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
export OLDPWD="$(<~/.previous-dir)"
