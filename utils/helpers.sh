#!/bin/bash


is_dotfile() {
    echo "$1" | grep -E '^\.' >/dev/null
    if [ "$?" -eq 0 ]; then
        return 0
    else
        return 1
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
