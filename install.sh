#!/bin/bash
#
# Mike Mob's dotfiles installer
#
# Delete dead symlinks
# find -L $(pwd) -maxdepth 3 -type l -delete
#
cd $(readlink -f "${0%/*}/")  # Set cd to script's directory

c() { read -n 1 -p "$@ (y/N) " a && [ ${a,,} = "y" ] && return 0; }
l() {
  # Test if target is a symlink
  [[ -L $2 ]] && return 0

  # Test if target exists and is not a symlink
  if [[ -e "$2" ]]; then
    if [[ ! -e "$1" ]]; then
      # Target exists and source does not exist
      c "* Move '$2' to '$(pwd)/$1'?" && mv "$2" "./$1"
    else
      # Target exists and source exists
      c "* '$2' exists... delete it?" && rm -rf "$2"
    fi
    echo
  fi

  # Create parent directories
  mkdir -p $(dirname "$2")

  # Create symbolic link
  ln -sf "$(pwd)/$1" "$2" && echo "Linked '$1' -> '$2'"
}


# Link files below:
l bashrc       ~/.bashrc
l compton.conf ~/.config/compton.conf
l compton.conf ~/.config/compton.conf
l tmux.conf    ~/.tmux.conf
l vimrc        ~/.vimrc
l ideavimrc    ~/.ideavimrc
l pypirc       ~/.pypirc

# Link directories below:
l i3           ~/.config/i3
l clementine   ~/.config/Clementine
l thunderbird  ~/.thunderbird
l alacritty    ~/.config/alacritty
l tmux         ~/.tmux
l scripts      ~/Scripts
l scripts      ~/.config/scripts
