#!/bin/bash

echo "source ~/.dotfiles/.vimrc" >> ~/.vimrc
echo "source ~/.dotfiles/.bashrc" >> ~/.bashrc
echo "include \"$HOME/.dotfiles/.gtkrc-2.0\"" >> ~/.gtkrc-2.0
echo "@import url(\"$HOME/.dotfiles/gtk.css\");" >> ~/.config/gtk-3.0/gtk.css

mkdir -p ~/.vim/tmpdirs/undodir
