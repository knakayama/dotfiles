# for japanese settings
if [[ -x "$(which uim-xim >/dev/null 2>&1)" ]]; then
    setxkbmap jp
    export GTK_IM_MODULE='uim'
    export QT_IM_MODULE='uim'
    uim-xim &
    export XMODIFIERS=@im='uim'
fi

if [[ -e ~/.xmodmap && -x "$(which xmodmap >/dev/null 2>&1)" ]]; then
    xmodmap ~/.xmodmap
fi

# execute ratpoison
if [[ -x "$(which ratpoison >/dev/null 2>&1)" ]]; then
    exec "$(which ratpoison >/dev/null 2>&1)"
fi

