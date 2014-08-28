#!/bin/sh

. "${HOME}/dotfiles/tmux-scripts/libs.sh"

DIR_NAME="${HOME}/dotfiles/tmux-scripts"

for script in $(ls -A "$DIR_NAME"); do
    if ! echo "$script" | grep -Eq '^(README\.md|(libs|status-line-right)\.sh|tmux-init\.(sh|json)|s)$'; then
        STATUS_LINE_RIGHT="${STATUS_LINE_RIGHT}${FG_BG_COLOR}$(${DIR_NAME}/${script})${PREFIX} < "
    fi
done

echo -n "$(echo $STATUS_LINE_RIGHT | perl -wlpe 's/(\s)<$/\1/')"

