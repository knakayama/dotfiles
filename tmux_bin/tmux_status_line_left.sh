#!/bin/bash

FG_BG_COLOR="#[fg=white,bg=black,bold]"
PREFIX="#[default]"
KEYS=("wan_ip")
STATUS_LINE_LEFT=()

declare -A outputs
outputs["wan_ip"]=$(~/dotfiles/tmux_bin/get_wan_ip.sh)

for key in ${KEYS[@]}; do
    if [[ "$key" == "wan_ip" ]]; then
        STATUS_LINE_LEFT+="${FG_BG_COLOR}${outputs["$key"]}${PREFIX}"
    fi
done

echo -n "$STATUS_LINE_LEFT"

