# for japanese settings
if [[ -x "$(which uim-xim 2>/dev/null)" ]]; then
    setxkbmap jp
    export GTK_IM_MODULE='uim'
    export QT_IM_MODULE='uim'
    uim-xim &
    export XMODIFIERS=@im='uim'
fi

if [[ -e ~/.xmodmap && -x "$(which xmodmap 2>/dev/null)" ]]; then
    xmodmap ~/.xmodmap
fi

# execute ratpoison
if [[ -x "$(which ratpoison 2>/dev/null)" ]]; then
    exec "$(which ratpoison 2>/dev/null)"
fi

