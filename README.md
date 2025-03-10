# .dotfiles

This repository configures my dotfiles for various programs. It is simple to run and does not require manually configuring symlinks!

## Usage

** This has only been tested on Ubuntu 22.04 and Ubuntu 24.04 **

```
sudo apt install git ansible
git clone https://github.com/patrickjcasey/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
ansible-playbook --ask-become-pass main.yaml
```

## Installs

- latest stable and nightly rust toolchains
- installs JetBrains Mono Nerd Font
- various development-related apt packages (curl, wget, xclip, tree, jq, tmux...)

## Build and install latest stable versions of the following programs:

- [alacritty](https://github.com/alacritty/alacritty)
- [neovim](https://github.com/neovim/neovim)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [starship](https://github.com/starship/starship)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [bat](https://github.com/sharkdp/bat)
- [zellij](https://github.com/zellij-org/zellij)

## Contains configuration for following programs:

- kitty
- i3
- neovim
- tmux
- zsh
- zellij
- tmux
- alacritty
- ghostty
- lazygit
- waybar
- starship

## Oddities

when running `nvidia-settings`, use `nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings`. This is because of this [issue](https://github.com/NVIDIA/nvidia-settings/issues/30)
