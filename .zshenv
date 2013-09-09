# path
if [[ -d "${HOME}/bin" ]]; then
    export PATH="${PATH}:${HOME}/bin"
fi

# rbenv
if [[ -d "${HOME}/.rbenv/bin" ]]; then
    if [[ -x "${HOME}/.rbenv/bin/rbenv" ]]; then
        export PATH="${PATH}:${HOME}/.rbenv/bin"
        eval "$(rbenv init -)"
    fi
fi

# auto-fu.zsh
if [[ -f "${HOME}/.zsh/plugin/auto-fu.zsh/auto-fu.zsh" ]]; then
    source "${HOME}/.zsh/plugin/auto-fu.zsh/auto-fu.zsh"
    function zle-line-init() {
        auto-fu-init
    }
    zle -N zle-line-init
fi

# xmonad-config
if [[ -d "${HOME}/.cabal" ]]; then
    PATH="${PATH}:${HOME}/.cabal/bin"
fi
if [[ -d "${HOME}/xmonad" ]]; then
    PATH="${PATH}:${HOME}/.xmonad/bin"
fi

# w3m
if [[ -x "$(which w3m >/dev/null 2>&1)" ]]; then
    export HTTP_HOME="http://www.google.com"
fi

# aws cli tools
if [[ -x "${HOME}/aws/bin/setting_aws_paths.sh" ]]; then
    source "${HOME}/aws/bin/setting_aws_paths.sh"
fi

# perlbrew
if [[ -x "${HOME}/perl5/perlbrew/bin/perlbrew" ]]; then
   source "${HOME}/perl5/perlbrew/etc/bashrc"
fi

