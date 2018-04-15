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
	ln -s $1 $2 && echo "Linked $DIR/$1 -> $2"
}


# Delete dead symlinks
# find -L $DIR -maxdepth 3 -type l -delete

#l $DIR/sublime-text-3 	$HOME/.config/sublime-text-3

l $DIR/bashrc			$HOME/.bashrc
l $DIR/osbuddy 			$HOME/.osbuddy
l $DIR/sublime-text-3		$HOME/.config/sublime-text-3
l $DIR/pypirc 			$HOME/.pypirc
l $DIR/ideavimrc		$HOME/.ideavimrc
l $DIR/nvim				$HOME/.config/nvim