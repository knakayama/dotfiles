#!/bin/bash


. utils.sh

usage() {
    echo
    echo "options supported by $(basename $0)"
    echo "-i prompt before remove"
    echo "-h this help"
    echo
}

yesno() {
    local answer
    echo -n "$1 (Yes/No): "
    while read answer; do
        case "$answer" in
            Y|y|[Yy][Ee][Ss])
                return 0
            ;;
            N|n|[Nn][Oo])
                return 1
            ;;
            *)
                echo -n "Please select Yes or No: "
            ;;
        esac
    done
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
done
