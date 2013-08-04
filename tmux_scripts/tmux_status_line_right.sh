#!/bin/sh

. ~/dotfiles/tmux_scripts/libs.sh

DIR_NAME=~/dotfiles/tmux_scripts

is_exclude_scripts() {
    if [ "$1" = "README.rst" -o "$1" = "libs.sh" -o "$1" = "tmux_status_line_right.sh" ]; then
        return 1
    else
        return 0
    fi
}

for script in $(ls -A "$DIR_NAME"); do
    is_exclude_scripts "$script"
    if [ "$?" -eq 0 ]; then
    STATUS_LINE_RIGHT="${STATUS_LINE_RIGHT}${FG_BG_COLOR}$(${DIR_NAME}/${script})${PREFIX} < "
    fi
done

echo -n "$(echo $STATUS_LINE_RIGHT | sed 's/ \<$/ /')"

