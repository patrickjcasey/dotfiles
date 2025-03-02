#!/bin/bash
# This script creates an tar archive of all configs/packages needed to configure nvim, tmux, zsh, and alacritty in an offline environment
OFFLINE=/tmp/offline_dev_setup
OFFLINE_ARCHIVE=$OFFLINE/dotfiles
echo "Deleting old $OFFLINE_ARCHIVE"
rm -rf $OFFLINE_ARCHIVE
mkdir -p $OFFLINE
mkdir -p $OFFLINE_ARCHIVE
mkdir -p $OFFLINE_ARCHIVE/.local/share
mkdir -p $OFFLINE_ARCHIVE/.config

echo "Copying neovim configuration and data"
cp -r ~/.dotfiles/dotfiles/nvim/ $OFFLINE_ARCHIVE/.config
cp -r ~/.local/share/nvim $OFFLINE_ARCHIVE/.local/share
tar cfvz /tmp/dotfiles.tar.gz $OFFLINE_ARCHIVE
