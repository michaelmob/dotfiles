#!/usr/bin/env bash
install() { yay -S --noconfirm --needed $@; }

# desktop environment
install i3
install picom
install flameshot
install playerctl
install keynav

# utilities
install zsh
install tmux
install neovim-git
install ripgrep
install rofi
install rofi-file-browser-extended-git

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
