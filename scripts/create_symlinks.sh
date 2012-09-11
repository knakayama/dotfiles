#!/bin/bash

EXCLUDE_TARGETS="
.git
.gitignore
.gitmodules
README.rst
fabfile.py*
tmux_bin
scripts
"

# default settings
BACKUP=1
NOW=$(date '+%Y%m%d%H%M%S')

usage() {
    prog_name="$(basename "$0")"
    cat << EOF
Usage: $prog_name [Options]

Options:

    -f no backup
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
            local source_file="${PWD}/${target}"
            local target_file="${HOME}/${target}"
            if [[ "$1" -eq 1 ]]; then
                if [[ -f "$target_file" ]]; then
                    mv "$target_file" "${target_file}.${NOW}"
                fi
                ln -s "$source_file" "$target_file"
            else
                ln -fs "$source_file" "$target_file"
            fi
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

