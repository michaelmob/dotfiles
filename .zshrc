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

# Zstyle
zstyle ':completion:*' menu select

# Fix slow tab completion
__git_files () { _wanted files expl 'local files' _files; }

# Prompt
PS1='%F{white}(%B%T%b)%f%B'
PS1+='%F{yellow}%n'
PS1+='%F{green}@'
PS1+='%F{blue}%m'
PS1+='%F{magenta} %c'
PS1+='%F{white}λ%b %f'

PS1='%F{white}%B%T%b%f%B '
PS1+='%F{red}['
PS1+='%F{yellow}%n%F{green}@%F{blue}%m '
PS1+='%F{magenta}%c'
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
alias l='ls --color=auto --group-directories-first'
alias serve='python -m http.server'
alias tardir="git ls-files | tar cvf 'out.tar' -T -"

# Config Aliases
alias vimrc='vim .vimrc'
alias zshrc="$EDITOR $HOME/.zshrc"
alias nvimrc="$EDITOR $HOME/.config/nvim/init.vim"
alias tmuxrc="$EDITOR .tmux.conf"

# Git Aliases
alias gs=''
alias gg='git status -vuno'
alias gd='git diff HEAD'
alias gc='git commit -vuno'
alias gu='git add -u'
alias gb='git branch'

# Includes
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
