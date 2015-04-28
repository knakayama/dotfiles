#!/bin/bash

# http://qiita.com/uasi/items/610ef5745fc35745fd54

ESC="$(printf "\033")"
FG_BLUE="34"
M="m"
DEFAULT="[${_DEFAULT}m"

usage(){
  cat <<EOT 1>&2
Usage: $(basename "$0") (-g <git-cmd>|-c <shell-cmd>) [-h]

  -h               print this help.
  -g <git-cmd>     execute git command.
  -c <shell-cmd>   execute shell command.

EOT
}

while getopts :g:c:h opts; do
  case "$opts" in
    g)
      GIT_CMD="$OPTARG"
      ;;
    c)
      SHELL_CMD="$OPTARG"
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

[[ -z "$GIT_CMD" && -z "$SHELL_CMD" ]] && { usage; exit 1; }
[[ -n "$GIT_CMD" && -n "$SHELL_CMD" ]] && { usage; exit 1; }

if ! which ghq >/dev/null 2>&1; then
  echo "ghq command not found in your ${PATH}." 1>&2
  exit 1
fi

ghq list --full-path | while read -r repo; do
  (
    cd "$repo"
    printf "${ESC}[${FG_BLUE}${M}$(pwd)${ESC}${DEFAULT}\n"
    if [[ -n "$GIT_CMD" ]]; then
      git "$GIT_CMD"
    else
      $SHELL_CMD
    fi
  )
done
