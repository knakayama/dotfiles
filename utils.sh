#!/bin/bash


is_dotfile() {
    echo "$1" | grep -E '^\.' >/dev/null
    if [ "$?" -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

is_exist() {
    if [ -f "$1" ]; then
        return 1
    else
        return 0
    fi
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
