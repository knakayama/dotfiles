#!/bin/bash


is_dotfile() {
    echo "$1" | grep -E '^\.' >/dev/null
    if [ "$?" -eq 0 ]; then
        return 0
    else
        return 1
    fi
}
