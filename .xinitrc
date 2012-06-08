# for japanese settings
setxkbmap jp
export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
uim-xim &
export XMODIFIERS=@im='uim'

# execute ratpoison
exec /usr/bin/ratpoison
#exec /usr/bin/xmonad


