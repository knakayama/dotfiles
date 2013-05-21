#!/bin/bash

source ~/dotfiles/tmux_scripts/libs.sh

#KEYS=("uptime" "loadaverage" "mem" "date")
KEYS=("uptime" "loadaverage" "mem")
STATUS_LINE_RIGHT=()

declare -A outputs
outputs["uptime"]=$(~/dotfiles/tmux_scripts/tmux_uptime.sh)
outputs["loadaverage"]=$(~/dotfiles/tmux_scripts/tmux_loadaverage.sh)
outputs["mem"]=$(~/dotfiles/tmux_scripts/tmux_mem.sh)
#outputs["date"]=$(~/dotfiles/tmux_scripts/tmux_date.sh)

echo -n "< "
for key in ${KEYS[@]}; do
    if [[ "$key" == "uptime" ]]; then
        STATUS_LINE_RIGHT+="${FG_BG_COLOR}${outputs["$key"]}${PREFIX} < "
    elif [[ "$key" == "loadaverage" ]]; then
        STATUS_LINE_RIGHT+="${FG_BG_COLOR}Avg:${outputs["$key"]}${PREFIX} < "
    elif [[ "$key" == "mem" ]]; then
        STATUS_LINE_RIGHT+="${FG_BG_COLOR}Mem:${outputs["$key"]}${PREFIX} "
    #else
    #    STATUS_LINE_RIGHT+="${FG_BG_COLOR}${outputs["$key"]}${PREFIX}"
    fi
done

echo -n "$STATUS_LINE_RIGHT"

