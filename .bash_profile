export EDITOR='nvim'
export VISUAL="$EDITOR"
. "$HOME/.cargo/env"

# Only run Homebrew shellenv in interactive shells,
# and only if brew actually exists.
if [[ $- == *i* ]] && [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
