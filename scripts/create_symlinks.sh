#!/bin/bash

EXCLUDE_TARGETS="
README.rst
fabfile.py
tmux_bin
scripts
"

# default settings
BACKUP=1
NOW=$(date '+%m%d%H%M%S')

usage() {
    prog_name="$(basename "$0")"
    cat << EOF
Usage: $prog_name [Options]

Options:

    -f force to create symlinks (no backup)
EOF
}

is_exclude_target() {
    for exclude_target in ${EXCLUDE_TARGETS[*]}; do
        if [[ "$1" =~ "$exclude_target" ]]; then
            return 0
        fi
    done

    return 1
}

create_symlinks() {
    cd "${HOME}/dotfiles"
    for target in $(ls -A); do
        is_exclude_target "$target"
        if [[ "$?" -eq 0 ]]; then
            continue
        else
            #echo "$target"
            local source_file="${HOME}/dotfiles/${target}"
            local target_file="${HOME}/${target}"
            ln -s "$source_file" "$target_file"
        fi
    done
}

while getopts :f flags; do
    case "$flags" in
        f)
            BACKUP=0
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done

create_symlinks "$BACKUP"

