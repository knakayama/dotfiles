#!/bin/bash

ARG="$@"

error() {
    tmux display-message "Unknown Argument: $ARG"
    exit 0
}

if [[ $(echo "$ARG" | grep -cE '[[:space:]]') -eq 0 ]]; then
    ACTION="$ARG"

    if echo "$ACTION" | grep -qE '^k$'; then
        HOST_NAME="kero"
    elif echo "$ACTION" | grep -qE '^c$'; then
        HOST_NAME="config"
    elif echo "$ACTION" | grep -qE '^o$'; then
        HOST_NAME="ops1"
    else
        error
    fi
elif [[ $(echo "$ARG" | grep -cE '[[:space:]]') -eq 1 ]]; then
    ACTION="$(echo "$ARG" | awk '{print $1}')"
    HOST_NAME="$(echo "$ARG" | awk '{print $2}')"
else
    error
fi

LOG_DIR="${HOME}/.tmuxlog/${HOST_NAME}/$(date '+%Y-%m/%d')"

[ -d "$LOG_DIR" ] || mkdir -p "$LOG_DIR"
[ "$?" -eq 0 ] || { tmux display-message "Can not create $LOG_DIR"; exit 0; }

case "$ACTION" in
    s)
        tmux new-window -n "$(echo "$HOST_NAME" | cut -d. -f1)" \
            "ssh -i /home/k-nakayama/.ssh/k-nakayama-kerberos -t kero 'sudo ssh $HOST_NAME'" \; \
            pipe-pane "cat >> ${LOG_DIR}/$(date '+%H:%M:%S').log"
        ;;
    k)
        tmux new-window -n "kero" "ssh kero" \; \
            pipe-pane "cat >> ${LOG_DIR}/$(date '+%H:%M:%S').log"
        ;;
    c)
        tmux new-window -n "config" "ssh config" \; \
            pipe-pane "cat >> ${LOG_DIR}/$(date '+%H:%M:%S').log"
        ;;
    o)
        tmux new-window -n "ops1" "ssh ops1" \; \
            pipe-pane "cat >> ${LOG_DIR}/$(date '+%H:%M:%S').log"
        ;;
    h)
        tmux split-window -h \
            "ssh -i /home/k-nakayama/.ssh/k-nakayama-kerberos -t kero 'sudo ssh $HOST_NAME'" \; \
            pipe-pane "cat >> ${LOG_DIR}/$(date '+%H:%M:%S').log"
        ;;
    v)
        tmux split-window -v \
            "ssh -i /home/k-nakayama/.ssh/k-nakayama-kerberos -t kero 'sudo ssh $HOST_NAME'" \; \
            pipe-pane "cat >> ${LOG_DIR}/$(date '+%H:%M:%S').log"
        ;;
    *)
        error
        ;;
esac
