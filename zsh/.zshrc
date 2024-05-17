[[ -f ~/.cargo/env ]] && source $HOME/.cargo/env

alias vim=nvim

VIM="nvim"
XDG_CONFIG_HOME=$HOME/.config
GIT_EDITOR=$VIM
DOTFILES=$HOME/.dotfiles
STOW_FOLDERS="kitty,i3,nvim,tmux,ubuntu_conf,zsh,alacritty,zellij"
PATH=$HOME/.cargo/bin:$HOME/.rustup:$PATH

# fzf
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd)"
