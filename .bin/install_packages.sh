#!/usr/bin/env bash
install() { yay -S --noconfirm --needed $@; }

# desktop environment
install i3
install xfce4
install dmenu
install compton
install flameshot
install playerctl
install keynav

# utilities
install zsh
install tmux
install neovim-git
install ripgrep

# development
install nodejs
install npm
install docker
install docker-compose
install vagrant
install virtualbox

# chat
install telegram-desktop
install discord

# multimedia
install mpv
install youtube-dl
install spotify
