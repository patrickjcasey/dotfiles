[[ -f ~/.cargo/env ]] && source $HOME/.cargo/env

# ensure ls has color
alias ls="ls --color=auto"

# avoid duplicates in history
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# write to zsh hist file instantly
setopt INC_APPEND_HISTORY

VIM="nvim"
XDG_CONFIG_HOME=$HOME/.config
GIT_EDITOR=$VIM
DOTFILES=$HOME/.dotfiles
PATH=$HOME/.cargo/bin:$HOME/.rustup:$PATH

# enable fzf, mainly for a better ctrl-r
if [[ "$(uname)" == "Darwin" ]]; then
    # Add fzf key bindings and fuzzy completion
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
else
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    source /usr/share/doc/fzf/examples/completion.zsh
fi

alias vim=nvim
alias cat="bat --theme gruvbox-dark"

eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd)"
