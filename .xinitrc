# for japanese settings
if [[ -x "$(which uim-xim)" ]]; then
    setxkbmap jp
    export GTK_IM_MODULE='uim'
    export QT_IM_MODULE='uim'
    uim-xim &
    export XMODIFIERS=@im='uim'
fi

if [[ -e ~/.xmodmap && -x "$(which xmodmap)" ]]; then
    xmodmap ~/.xmodmap
fi

# execute ratpoison
if [[ -x "$(which ratpoison)" ]]; then
    exec "$(which ratpoison)"
fi

