# remove duplicate path
typeset -U path cdpath fpath manpath

# local utils
path=(${HOME}/bin(N-/) $path)

# rbenv
path=(${HOME}/.rbenv/shims(N-/) $path)
path=(${HOME}/.rbenv/bin(N-/) $path)
if type rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# go
if [[ -x "/usr/bin/go" ]] || [[ -x "/usr/local/bin/go" ]]; then
  export GOPATH="${HOME}/go/vendor"
  [[ -d "${HOME}/go" ]] || mkdir "${HOME}/go"
  path=($path ${GOPATH}/bin)
fi

# heroku
path=($path /usr/local/heroku/bin(N-/))

# rsense
path=($path ${HOME}/rsense-0.3/bin(N-/))
