# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/Users/neo/.local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=/usr/local/bin:$PATH

. "$HOME/.cargo/env"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
# Remove "zi" alias for default zoxide alias to work
zinit ice atload'unalias zi'

# Alias
alias vi="nvim"
alias ls='eza --icons -F -H --group-directories-first --git'
alias ll='ls -alF'

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_PLUGINS="$HOME/.zsh-plugins"
export XDG_CONFIG_HOME="$HOME/.config"

# zinit plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward

# completions
autoload -U compinit && compinit

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:z:*' fzf-preview 'ls --color $realpath'

zinit cdreplay -q

# ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

export LC_ALL=en_US.UTF-8

eval $(thefuck --alias)
eval "$(fzf --zsh)"
eval "$(gh copilot alias -- zsh)"

plugins=(
  git
#   autojump
)

source $ZSH/oh-my-zsh.sh
# source $ZSH_PLUGINS/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh

export EDITOR='nvim'
export VISUAL="$EDITOR"

# nvm
export NVM_DIR="${HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Run neofetch
# neofetch

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
