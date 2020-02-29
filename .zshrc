#!/usr/bin/env zsh
# vim: et sw=2

# Environment
export GEM_HOME="$HOME/.gem"
export PATH="$HOME/.bin:$HOME/.gem/ruby/2.7.0/bin:$PATH"
[[ -z "$XDG_CONFIG_HOME" ]] && export XDG_CONFIG_HOME="$HOME/.config"

# Default Applications
export TERMINAL='alacritty'
export EDITOR='nvim'
export BROWSER='brave'

# Options
setopt autocd  # set cd without cd
setopt hist_verify  # expand history entry
setopt extended_history  # add timestamp in history
setopt hist_ignore_dups  # ignore duplicate commands in history
setopt hist_ignore_space  # ignore commands that start with space
setopt inc_append_history  # add history on run
export WORDCHARS=''

# Autoload
autoload -U colors && colors  # use colors
autoload -U compinit && compinit  # tab completion
autoload -U edit-command-line

zle -N edit-command-line

bindkey -e  # emacs keybindings
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
bindkey "\e[3~" delete-char  # delete key
for x in 'ABCD'; do bindkey "\e[1;5$x" ''; done  # disable ctrl+arrow keys

# Zstyle
zstyle ':completion:*' menu select

# Fix slow tab completion
__git_files () { _wanted files expl 'local files' _files; }

# Prompt
PS1="%F{white}(%B%T%b)%f%B%F{red}["
PS1+="%F{yellow}%n"
PS1+="%F{green}@"
PS1+="%F{blue}%m"
PS1+="%F{magenta} %c"
PS1+="%F{red}]"
PS1+="%F{white}λ%b %f"

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

# Config Aliases
alias i3rc=":e $XDG_CONFIG_HOME/i3/config"
alias kakrc=":e $XDG_CONFIG_HOME/kak/kakrc"
alias zshrc=":e $HOME/.zshrc"
alias dwmrc="cd $HOME/Workspace/dwm && :e config.h"
alias vimrc='vim .vimrc'
alias nvimrc=":e $XDG_CONFIG_HOME/nvim/init.vim"
alias tmuxrc=":e $HOME/.tmux.conf"
alias awesomerc=":e $XDG_CONFIG_HOME/awesome/rc.lua"
alias alacrittyrc=":e $XDG_CONFIG_HOME/alacritty/alacritty.yml"
alias tridactylrc=":e $XDG_CONFIG_HOME/tridactyl/tridactylrc"

# make install
alias mi='make && sudo make install'

# Git Aliases
alias gs='git status -vuno'
alias gd='git diff HEAD'
alias gc='git commit -vuno'
alias gu='git add -u'
alias gb='git branch'

# Includes
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# SSH Agent
export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"
if [[ ! -S "$HOME/.ssh/ssh_auth_sock" ]]; then
  eval "$(ssh-agent)"
  ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh_auth_sock"
fi
ssh-add -l > /dev/null || ssh-add "$HOME/.ssh/"*_rsa

# Attach to unattached number session or create a new session
if [[ -z "$TMUX" ]] && [[ $- == *i* ]]; then
  unattached_id="${$(tmux ls | grep -m 1 -Pve '(^\D+|(attached))')%%:*}"
  [[ -z "$unattached_id" ]] && exec tmux || exec tmux attach -t $unattached_id
fi
