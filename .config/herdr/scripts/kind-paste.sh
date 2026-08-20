#!/usr/bin/env bash
# Paste the clipboard into the focused herdr pane, tmux-newline-detector style.
# The command substitution strips trailing newlines (the "kindness"), so a
# single line with a trailing newline no longer auto-runs in the shell.
# Multi-line content is wrapped in bracketed paste so the shell inserts it
# without executing each line, since `herdr pane send-text` sends raw bytes.
set -uo pipefail

text="$(pbpaste)"

if printf '%s' "$text" | grep -q $'\n'; then
  text=$'\033[200~'"$text"$'\033[201~'
fi

"$HERDR_BIN_PATH" pane send-text "$HERDR_ACTIVE_PANE_ID" "$text"
