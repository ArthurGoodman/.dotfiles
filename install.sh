#!/bin/bash

#echo "include \"$HOME/.dotfiles/.gtkrc-2.0\"" >> ~/.gtkrc-2.0
#echo "@import url(\"$HOME/.dotfiles/gtk.css\");" >> ~/.config/gtk-3.0/gtk.css

ln -snf ~/.dotfiles/.vimrc ~/.vimrc
ln -snf ~/.dotfiles/.bashrc.mine ~/.bashrc.mine
ln -snf ~/.dotfiles/.profile.mine ~/.profile.mine

cp -rsPf ~/.dotfiles/.config ~
cp -rsPf ~/.dotfiles/.scripts ~

echo "source $HOME/.bashrc.mine" >> ~/.bashrc
echo "source $HOME/.profile.mine" >> ~/.profile

mkdir -p ~/.vim/tmpdirs/undodir
