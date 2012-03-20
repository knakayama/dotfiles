#!/bin/bash


. utils.sh

ABS_DNAME_PATH="$(pwd)"
REL_DNAME_PATH="$(basename "$(pwd)")"

usage() {
    echo
    echo "options supported by $(basename $0)"
    echo "-i prompt before making symbolic link"
    echo "-n do not make backup file"
    echo "-h this help"
    echo
}

backup() {
    mv "$1" "${1}.bak"
}

while getopts inh flag; do
    case "$flag" in
        i)
            i_flag="$flag"
        ;;
        n)
            n_flag="$flag"
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

for fname in $(ls -A); do
    dotfile_path="${HOME}/$fname"
    source_path="${ABS_DNAME_PATH}/$fname"

    is_dotfile "$fname"
    if [ "$?" -ne 0 ]; then
        continue
    fi

    is_git_file "$fname"
    if [ "$?" -ne 0 ]; then
        continue
    fi

    is_exist "$source_path"
    if [ "$?" -eq 0 ]; then
        [ -n "$n_flag" ] && backup "$dotfile_path"
    fi

    if [ -n "$i_flag" ]; then
        yesno "make symbolic link $fname -> ${REL_DNAME_PATH}/$fname?"
        if [ "$?" -eq 0 ]; then
            ln -s "$source_path" "$dotfile_path"
        fi
    else
        ln -s "$source_path" "$dotfile_path"
    fi

    if [ "$?" -eq 0 ]; then
        echo "created symbolic link $fname -> ${REL_DNAME_PATH}/$fname"
    fi
done
