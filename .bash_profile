#
# ~/.bash_profile
#

[[ -f "${HOME}/.bashrc" ]] && . "${HOME}/.bashrc"

# autologin
if [[ -z "$DISPLAY" && $(tty) = "/dev/tty1" ]]; then
    exec startx
fi

# use zsh
if [[ -f "/bin/zsh" ]]; then
    exec /bin/zsh
fi

