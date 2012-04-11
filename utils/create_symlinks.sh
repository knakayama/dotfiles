#!/bin/bash

. helpers.sh

ABS_DNAME="$(dirname "$(pwd)")"
REL_DNAME="$(basename "$(cd ..;pwd)")"
DATE="$(date +%Y_%m_%d_%H_%M_%S)"
DOTFILES_LIST="dotfiles.txt"


backup() {
    local new_name="${1}.$DATE"

    mv "$1" "$new_name"
    echo "backuped $1 to $new_name"
}


for dotfile in $(cat "$DOTFILES_LIST"); do
    source_path="${ABS_DNAME}/$dotfile"
    dotfile_path="${HOME}/$dotfile"

    if [ -f "$dotfile_path" ]; then
        backup "$dotfile_path"
    fi

    ln -s "$source_path" "$dotfile_path"
    if [ "$?" -eq 0 ]; then
        echo "created $dotfile -> ${REL_DNAME}/$dotfile"
    fi
done
