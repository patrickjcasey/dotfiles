#!/usr/bin/env bash

# this script sets up config and data files for an offline install using stow
tar zxvf dotfiles.tar.gz
mkdir -p ~/.config
cp -r dotfiles/.local ~
stow dotfiles/dotfiles -t ~/.config
ln -s ~/.config/zsh/.zshrc ~/.zshrc
