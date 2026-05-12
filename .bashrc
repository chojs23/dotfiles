[ -f "$HOME/.shell_common" ] && source "$HOME/.shell_common"

# Make sure this stuff is in the path.
export PATH="$HOME/.cargo/bin:$PATH" # Cargo
export PATH="$HOME/.local/bin:$PATH" # Local scripts

# Use neovim as the default editor.
export EDITOR=nvim
export VISUAL=nvim

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
  export VISUAL="nvim"
fi

# Ripgrep.
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/.ripgreprc"

export EDITOR="$VISUAL"
. "$HOME/.cargo/env"

alias grep="rg"
alias find="fd"

eval "$(starship init bash)"

. "$HOME/.local/share/../bin/env"
