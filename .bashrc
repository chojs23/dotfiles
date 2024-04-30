# Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/bashrc.pre.bash" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/bashrc.pre.bash"
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
	export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
	export VISUAL="nvim"
fi

export EDITOR="$VISUAL"
. "$HOME/.cargo/env"

# Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/bashrc.post.bash" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/bashrc.post.bash"
