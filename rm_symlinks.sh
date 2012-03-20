#!/bin/bash


. utils.sh

usage() {
    echo
    echo "options supported by $(basename $0)"
    echo "-i prompt before removing"
    echo "-h this help"
    echo
}

while getopts ih flag; do
    case "$flag" in
        i)
            i_flag="$flag"
        ;;
        h)
            usage
            exit 0
        ;;
        *)
            usage
            exit 1
        ;;
    esac
done

cd "$HOME"

for fname in $(ls -A); do
    if [ -h "$fname" ]; then
        is_dotfile "$fname"
        if [ "$?" -ne 0 ]; then
            continue
        fi
        symlink_name="$(ls -l "$fname" | cut -d' ' -f10-)"
        if [ -n "$i_flag" ]; then
            yesno "remove ${symlink_name}?"
            if [ "$?" -ne 0 ]; then
                continue
            fi
        fi

        rm "$fname" && echo "removed $symlink_name"
    fi

    echo
done
