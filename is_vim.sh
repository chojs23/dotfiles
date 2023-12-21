#!/usr/bin/env bash
# For code whisperer with vim tmux
# Usage: is_vim.sh <tty>
#   tty: Specify tty to check for vim process.
#   replace is_vim="~/is_vim.sh '#{pane_tty}'"
tty=$1

# Construct process tree.
children=()
pids=($(ps -o pid= -t $tty))

while read -r pid ppid; do
	[[ -n pid && pid -ne ppid ]] && children[ppid]+=" $pid"
done <<<"$(ps -Ao pid=,ppid=)"

# Get all descendant pids of processes in $tty with BFS
idx=0
while ((${#pids[@]} > idx)); do
	pid=${pids[idx++]}
	pids+=(${children[pid]-})
done

# Check whether any child pids are vim
ps -o state=,comm= -p "${pids[@]}" | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'
exit $?
