# remove duplicate path
typeset -U path cdpath fpath manpath

#cdpath=(~)

# autoload func path
if [[ -x "$(which brew 2>/dev/null)" ]]; then
  fpath=("$(brew --prefix)/share/zsh-completions" $fpath)
fi

# set PATH
path=($HOME/bin(N-/) /usr/local/sbin(N-/) /usr/local/bin(N-/) $path)

# auto-fu.zsh
if [[ -f "${HOME}/.zsh/plugin/auto-fu.zsh/auto-fu.zsh" ]]; then
  source "${HOME}/.zsh/plugin/auto-fu.zsh/auto-fu.zsh"
  function zle-line-init() {
    auto-fu-init
  }
  zle -N zle-line-init
fi

# w3m
if [[ -x "$(which w3m >/dev/null 2>&1)" ]]; then
  export HTTP_HOME="http://www.google.com"
fi

# perlbrew
if [[ -d "${HOME}/perl5/perlbrew/etc/bashrc" ]]; then
  source "${HOME}/perl5/perlbrew/etc/bashrc"
fi

# rbenv
if [[ -d "${HOME}/.rbenv" ]]; then
  echo "$PATH" | grep -qE "^${HOME}/.rbenv/shims" || eval "$(rbenv init -)"
fi

# direnv
if [[ -x "/usr/local/bin/direnv" ]]; then
  eval "$(direnv hook zsh)"
fi

# go
if [[ -x "/usr/bin/go" || -x "/usr/local/bin/go" ]]; then
  export GOPATH="${HOME}/go/vendor"
  [[ -d "${HOME}/go" ]] || mkdir "${HOME}/go"
  echo "$PATH" | grep -q "${GOPATH}/bin" || export PATH="${PATH}:${GOPATH}/bin"
fi

# nvm
if [[ -f "${HOME}/.nvm/nvm.sh" ]]; then
  source "${HOME}/.nvm/nvm.sh"
fi
if [[ -f "${HOME}/.nvm/bash_completion" ]]; then
  source "${HOME}/.nvm/bash_completion"
fi

# heroku
if [[ -x "/usr/bin/heroku" ]]; then
  echo "$PATH" | grep -qF '/usr/local/heroku/bin/' || export PATH="/usr/local/heroku/bin:${PATH}"
fi

# ghq
if [[ -f "${HOME}/.ghq/github.com/motemen/ghq/zsh/_ghq" ]]; then
  fpath=($fpath "${HOME}/.ghq/github.com/motemen/ghq/zsh")
fi

# rsense
if [[ -d "${HOME}/rsense-0.3/bin" ]] && [[ "$(uname)" == "Linux" ]]; then
  echo "$PATH" | grep -q "${HOME}/rsense-0.3/bin" || export PATH="${PATH}:${HOME}/rsense-0.3/bin"
fi

# pyenv
if type pyenv &>/dev/null; then
  eval "$(pyenv init -)";
fi
