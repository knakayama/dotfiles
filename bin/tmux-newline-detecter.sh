#!/bin/sh

if reattach-to-user-namespace pbpaste | hexdump | grep -qE '[[:space:]](0a|0d|0d0a)[[:space:]]?'; then
    tmux confirm-before -p "Include newline. Paste?(y/n)" \
        "run-shell 'reattach-to-user-namespace pbpaste | tmux load-buffer - && tmux paste-buffer'"
else
    reattach-to-user-namespace pbpaste | tmux load-buffer - && tmux paste-buffer
fi

