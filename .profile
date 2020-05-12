#!/bin/sh
: ${XDG_CONFIG_HOME:=$HOME/.config}
export GEM_HOME="$HOME/.gem"
export PATH="$HOME/.local/bin:$HOME/.gem/ruby/2.7.0/bin:$PATH"
export WORDCHARS=''

export EDITOR='nvim'
export TERMINAL='alacritty'
export BROWSER='brave'
