#!/bin/bash


. utils.sh

is_exist() {
    if [ -f "$1" ]; then
        return 1
    else
        return 0
    fi
}

backup() {
    mv "${HOME}/$1" "${HOME}/${1}.bak"
}

for fname in $(ls -A); do
    dotfile_path="${HOME}/$fname"
    dotfiles_path="${HOME}/dotfiles/$fname"

    is_dotfile "$dotfiles_path"
    if [ "$?" -ne 0 ]; then
        continue
    fi

    is_exist "$dotfile_path"
    if [ "$?" -ne 0 ]; then
        backup "$fname"
    fi

    ln -s "$dotfiles_path" "$dotfile_path"
    if [ "$?" -eq 0 ]; then
        echo "created $dotfile_path"
    fi
done
