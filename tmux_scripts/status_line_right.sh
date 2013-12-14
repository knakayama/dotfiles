#!/bin/sh

. "${HOME}/dotfiles/tmux_scripts/libs.sh"

DIR_NAME="${HOME}/dotfiles/tmux_scripts"

is_exclude() {
    if [ "$1" = "README.rst" -o "$1" = "libs.sh" -o "$1" = "status_line_right.sh" ]; then
        return 0
    else
        return 1
    fi
}

for script in $(ls -A "$DIR_NAME"); do
    is_exclude "$script" || STATUS_LINE_RIGHT="${STATUS_LINE_RIGHT}${FG_BG_COLOR}$(${DIR_NAME}/${script})${PREFIX} < "
done

echo -n "$(echo $STATUS_LINE_RIGHT | perl -wlpe 's/(\s)<$/\1/')"

