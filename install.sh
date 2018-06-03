#!/bin/bash
DIR=$(readlink -f "${0%/*}/")

l () {
    # Test target exists
    if [ -e "$2" ]; then
        if [ -L "$2" ]; then
            # Link already exists
            echo "$2 already linked"
            return 0
        else
            # Exists, but not link? Prompt deletion
            echo -e "\n\e[7m!!! $2 already exists !!!\e[0m"
            rm -rI "$2" && [ -e "$2" ] && return 1
        fi
    fi

    # Create symbolic link
    ln -s "$1" "$2" && echo "Linked $1 -> $2"
}


# Delete dead symlinks
# find -L $DIR -maxdepth 3 -type l -delete

l $DIR/bashrc       $HOME/.bashrc
l $DIR/i3           $HOME/.config/i3
l $DIR/vim          $HOME/.config/vim
l $DIR/vimrc        $HOME/.vimrc
l $DIR/ideavimrc    $HOME/.ideavimrc
l $DIR/pypirc       $HOME/.pypirc
