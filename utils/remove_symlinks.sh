#!/bin/bash


. helpers.sh


for target in $(ls -A "$HOME"); do
    abs_target_path="${HOME}/$target"
    if [ ! -h "$abs_target_path" ]; then
        continue
    fi

    is_dotfile "$target"
    if [ "$?" -ne 0 ]; then
        continue
    fi

    symlink_name="$(ls -l "$abs_target_path" | cut -d' ' -f10-)"
    yesno "remove $symlink_name?"
    if [ "$?" -eq 0 ]; then
        rm "$abs_target_path" && echo "removed $target"
    fi
done

