# avoid duplicates in history
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_VERIFY
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

export EDITOR="nvim"
export XDG_CONFIG_HOME=$HOME/.config
export GIT_EDITOR=$EDITOR
export DOTFILES=$HOME/.dotfiles

if [[ -d /opt/homebrew/bin ]]; then
    PATH=/opt/homebrew/bin:$PATH
fi

# initialize completion system before fzf sources its completion script
autoload -Uz compinit && compinit

# load cargo environments
[[ -f ~/.cargo/env ]] && source $HOME/.cargo/env

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

# starship config lives at ~/.config/starship/config.toml
export STARSHIP_CONFIG=~/.config/starship/config.toml

eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd)"

