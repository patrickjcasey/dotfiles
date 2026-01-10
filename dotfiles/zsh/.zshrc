[[ -f ~/.cargo/env ]] && source $HOME/.cargo/env

# avoid duplicates in history
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_VERIFY
setopt appendhistory
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

VIM="nvim"
XDG_CONFIG_HOME=$HOME/.config
GIT_EDITOR=$VIM
DOTFILES=$HOME/.dotfiles
PATH=$HOME/.cargo/bin:$HOME/.rustup:$PATH

# enable fzf (cross-platform)
if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
    # Debian/Ubuntu Linux
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    source /usr/share/doc/fzf/examples/completion.zsh
elif [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
    # Homebrew on Apple Silicon
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
    source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

alias vim=nvim
alias cat="bat --theme gruvbox-dark"

eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd)"

# bun completions
[ -s "/home/trick/.bun/_bun" ] && source "/home/trick/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# move starship config to ~/.config/starship/config.toml
export STARSHIP_CONFIG=~/.config/starship/config.toml

# opencode
export PATH=$HOME/.opencode/bin:$PATH

# claude
export PATH=$HOME/.local/bin:$PATH
