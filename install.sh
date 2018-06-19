#!/bin/bash
cd $(readlink -f "${0%/*}/")

c() { read -n 1 -p "$@ (y/N) " a && [ ${a,,} = "y" ] && return 0; }
l() {
  # Test if file is a symlink
  test -L $2 && return 0

  # Test if file exists and is not a symlink
  if [[ -a $2 ]]; then
    if [[ ! -a $1 ]]; then
      # Target exists and symlink does not exist
      c "* Move '$2' to '$(pwd)/$1'?" && mv "$2" "./$1"
    else
      # Target exists and symlink exists
      c "* File '$2' exists... delete it?" && rm "$2"
    fi
  fi

  # Create parent directories
  mkdir -p $(dirname $2)

  # Create symbolic link
  ln -sf "$(pwd)/$1" "$2"
}


# Delete dead symlinks
# find -L $(pwd) -maxdepth 3 -type l -delete

l bashrc        ~/.bashrc
l tmux          ~/.tmux
l tmux.conf     ~/.tmux.conf
l vimrc         ~/.vimrc
l ideavimrc     ~/.ideavimrc
l pypirc        ~/.pypirc
l thunderbird   ~/.thunderbird
