#!/bin/bash

# https://github.com/y-uuki/opstools

CONF_FILE="${HOME}/bin/tmux-sync-ssh.conf"

if [[ -f "$CONF_FILE" ]]; then
  source "$CONF_FILE"
else
  echo "$CONF_FILE not found"
  exit 1
fi

hosts=("$@")
session_name="tmux-ssh-$$"

tmux start-server

is_first="true"
for host in ${hosts[@]}; do
  cmd="ssh $SSH_OPTION 'sudo ssh $host'"
  if [[ "$is_first" == "true" ]]; then
    tmux new-session -d -s "$session_name" "$cmd"

    is_first="false"
  else
    tmux split-window  -t "$session_name" "$cmd"
    tmux select-layout -t "$session_name" tiled >/dev/null
  fi
done

tmux set-window-option -t "$session_name" synchronize-panes on
tmux select-pane -t 0
tmux attach-session -t "$session_name"

