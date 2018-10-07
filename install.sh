#!/bin/bash

ln -snf ~/.dotfiles/.vimrc ~/.vimrc
ln -snf ~/.dotfiles/.inputrc ~/.inputrc
ln -snf ~/.dotfiles/.bashrc ~/.bashrc
ln -snf ~/.dotfiles/.profile ~/.profile
ln -snf .profile ~/.bash_profile

cp -rsPf ~/.dotfiles/.config ~
cp -rsPf ~/.dotfiles/.scripts ~

mkdir -p ~/.vim/tmpdirs/undodir
