# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/Users/neo/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export XDG_CONFIG_HOME="$HOME/.config"

# ZSH_THEME="powerlevel9k/powerlevel9k"


# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

export LC_ALL=en_US.UTF-8

eval $(thefuck --alias)


plugins=(
  git
  autojump
)

source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/autojump/autojump.zsh
# zsh vi mode
# source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='nvim'
# else
#   export EDITOR='nvim'
# fi

export EDITOR='nvim'
export VISUAL="$EDITOR"

alias vi="nvim"
alias ls='exa --icons -F -H --group-directories-first --git -1'
alias ll='ls -alF'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

#pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

#jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# rbenv PATH
[[ -d ~/.rbenv ]] &&
  export PATH=${HOME}/.rbenv/bin:${PATH} &&
  eval "$(rbenv init -)"

# Run neofetch
# neofetch

eval "$(starship init zsh)"
