#!/usr/bin/env bash
echo "Merging $HOME/dotfiles into $HOME"
rsync -a $HOME/dotfiles/ $HOME/

echo "Merging $HOME/dotfiles/.root into /"
sudo rsync -a --no-o --no-g $HOME/dotfiles/.root/ /
