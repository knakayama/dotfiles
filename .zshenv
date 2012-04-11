# path
if [ -d "$HOME/bin" ]; then
    export PATH=$PATH:"$HOME/bin"
fi

# rbenv
if [ -d "$HOME/.rbenv/bin" ]; then
    if [ -x "$HOME/.rbenv/bin/rbenv" ]; then
        export PATH=$PATH:"$HOME/.rbenv/bin"
        eval "$(rbenv init -)"
    fi
fi

# auto-fu.zsh
if [ -f "$HOME/.zsh/plugin/auto-fu.zsh" ]; then
    source "$HOME/.zsh/plugin/auto-fu.zsh"
    zle-line-init() {
        auto-fu-init
    }
    zle -N zle-line-init
fi

