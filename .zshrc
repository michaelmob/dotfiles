#!/usr/bin/env zsh
# vim: et sw=2
source $HOME/.profile

# Options
setopt AUTOCD  # set cd without cd
setopt HIST_VERIFY  # expand history entry
setopt EXTENDED_HISTORY  # add timestamp in history
setopt HIST_IGNORE_DUPS  # ignore duplicate commands in history
setopt HIST_IGNORE_SPACE  # ignore commands that start with space
setopt INC_APPEND_HISTORY  # add history on run

# Line Editor
zle -N edit-command-line

# Autoload
autoload -U colors && colors  # use colors
autoload -U compinit && compinit  # tab completion
autoload -U edit-command-line

bindkey -e  # emacs keybindings
bindkey '^x^e' edit-command-line  # ctrl-x ctrl-e to edit long commands
bindkey '\e[3~' delete-char  # delete key
bindkey '\e[1;5A' nop  # disable ctrl-up
bindkey '\e[1;5B' x  # disable ctrl-down
bindkey '\e[1;5C' x  # disable ctrl-right
bindkey '\e[1;5D' x  # disable ctrl-right

# Zstyle
zstyle ':completion:*' menu select

# Fix slow tab completion
__git_files () { _wanted files expl 'local files' _files; }

# Prompt
PS1='%F{white}(%B%T%b)%f%B%F{red}['
PS1+='%F{yellow}%n'
PS1+='%F{green}@'
PS1+='%F{blue}%m'
PS1+='%F{magenta} %c'
PS1+='%F{red}]'
PS1+='%F{white}λ%b %f'

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000

# Functions
f() { find ${@:2} -iname "*$1*" 2> /dev/null; }  # Case-insensitive find
c() { awk "NR>1 {print \$$1}"; }  # Print column number without first line

# Helper Aliases
alias \?='bindkey | head -n 23'
alias :q='exit'
alias :e="$EDITOR"
alias ls='ls --color=auto --group-directories-first'
alias xclip='xclip -selection c'
alias serve='python -m http.server'
alias tardir="git ls-files | tar cvf '${PWD##*/}.tar' -T -"

# Config Aliases
alias i3rc=":e $XDG_CONFIG_HOME/i3/config"
alias i3statusrc=":e $XDG_CONFIG_HOME/i3status/config"
alias rofirc=":e $XDG_CONFIG_HOME/rofi/config.rasi"
alias zshrc=":e $HOME/.zshrc"
alias vimrc='vim .vimrc'
alias nvimrc=":e $XDG_CONFIG_HOME/nvim/init.vim"
alias tmuxrc=":e $XDG_CONFIG_HOME/tmux/tmux.conf"
alias alacrittyrc=":e $XDG_CONFIG_HOME/alacritty/alacritty.yml"
alias tridactylrc=":e $XDG_CONFIG_HOME/tridactyl/tridactylrc"

# Git Aliases
alias gg='git status -vuno'
alias gd='git diff HEAD'
alias gc='git commit -vuno'
alias gu='git add -u'
alias gb='git branch'

# Includes
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
