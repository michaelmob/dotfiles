#!/usr/bin/env zsh
# vim: et sw=2
#
export PATH="$HOME/.local/bin:$HOME/.scripts:$PATH"

bindkey -e  # emacs keybindings
bindkey "\e[3~" delete-char  # delete key
for x in 'ABCD'; do bindkey "\e[1;5$x" ''; done  # disable ctrl+arrow keys

# Default Applications
export TERMINAL='urxvt'
export EDITOR='nvim'
export BROWSER='firefox'
export FM='nautilus'

# Options
setopt autocd  # set cd without cd
setopt hist_verify  # expand history entry
setopt extended_history  # add timestamp in history
setopt hist_ignore_dups  # ignore duplicate commands in history
setopt hist_ignore_space  # ignore commands that start with space
setopt inc_append_history  # add history on run

# Autoload
autoload -U colors && colors  # use colors
autoload -U compinit && compinit  # tab completion

# Zstyle
zstyle ':completion:*' menu select

# Prompt
PS1="%B%F{red}["
PS1+="%F{yellow}%n"
PS1+="%F{green}@"
PS1+="%F{blue}%m"
PS1+="%F{magenta} %c"
PS1+="%F{red}]"
PS1+="%F{white}λ%b %f"
RPS1="%B%T%b"

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000

# Aliases
alias \?='bindkey | head -n 23'
alias :q='exit'
alias ls='ls --color=auto --group-directories-first'
alias xclip='xclip -selection c'

# Config Aliases
alias nvimrc="nvim $HOME/.config/nvim/init.vim"
alias tmuxrc="nvim $HOME/.tmux.conf"
alias zshrc="nvim $HOME/.zshrc"
alias i3rc="nvim $HOME/.config/i3/config"

alias gs='git status -uno'
alias gd='git diff HEAD'
alias gc='git commit'
alias gu='git add -u'

# Includes
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
