#!/bin/bash
# This script creates a tar archive of all configs and data needed to configure dotfiles (including neovim, tmux, zsh, alacritty, ghostty, i3, etc.) in an offline environment
OFFLINE=/tmp/offline_dev_setup
OFFLINE_ARCHIVE=$OFFLINE/dotfiles
echo "Deleting old $OFFLINE_ARCHIVE"
rm -rf $OFFLINE_ARCHIVE
mkdir -p $OFFLINE
mkdir -p $OFFLINE_ARCHIVE
mkdir -p $OFFLINE_ARCHIVE/.local/share

echo "Copying all dotfiles configurations"
cp -r ~/.dotfiles/dotfiles $OFFLINE_ARCHIVE/
echo "Copying neovim data"
cp -r ~/.local/share/nvim $OFFLINE_ARCHIVE/.local/share
tar cfvz /tmp/dotfiles.tar.gz $OFFLINE_ARCHIVE
