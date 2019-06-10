# History
SAVEHIST=5000
HISTSIZE=5000
HISTFILE=~/.zsh_history
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt incappendhistory

# Extensions
autoload -U colors && colors
autoload -U predict-on && predict-on

# Emacs-like keybindings
bindkey -e

# Blur
if [[ $(ps --no-header -p $PPID -o comm) =~ '^(yakuake|alacritty)$' ]]; then
  local blur=_KDE_NET_WM_BLUR_BEHIND_REGION
  for wid in $(xdotool search --pid $PPID); do
    xprop -f $blur 32c -set $blur 0 -id $wid
  done
fi

# FZF
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Aliases
alias :q='exit'
alias ls='ls --color=auto'
alias l='ls'

# Environment
export LC_ALL='en_US.UTF-8'
export PS1='%B%{%F{blue}%}%~ %{%F{white}%}$ %b'
