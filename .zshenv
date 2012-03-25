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
