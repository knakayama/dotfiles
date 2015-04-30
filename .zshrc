####################
# Alias
####################
if [[ -f "${HOME}/.zsh_aliases" ]]; then
  source "${HOME}/.zsh_aliases"
fi

####################
# Completion
####################

# enable completion
autoload -U compinit
compinit # also compinit -u

zstyle ':completion:*' completer _oldlist _complete

# specify ignored patterns whene completing
# fignore=(.sh)

# specify confirm message when completing
# LISTMAX=20

#cdpath=(~)

# autoload func path
if [[ -x "$(which brew 2>/dev/null)" ]]; then
  fpath=("$(brew --prefix)/share/zsh-completions" $fpath)
fi

# remove duplicate path
typeset -U path cdpath fpath manpath

####################
# PROMPT
####################

# PROMPT  -> left prompt
# RPROMPT -> right prompt
# PROMPT2 -> prompt when displaying 2 line
# SPROMPT -> prompt when entering error command

# enable color prompt
autoload -U colors; colors
# prompt theme
autoload -U promptinit; promptinit
# see prompt preview -> prompt -p <theme>
# see current theme -> prompt -c
#prompt walters

autoload -Uz VCS_INFO_get_data_git
VCS_INFO_get_data_git 2> /dev/null
compinit -u

function get_git_current_branch {
  local branch_name git_status color gitdir action

  if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == "true" ]]; then
    branch_name="$(git rev-parse --abbrev-ref=loose HEAD 2> /dev/null)"
    [[ -z "$branch_name" ]] && return 0

    gitdir="$(git rev-parse --git-dir 2> /dev/null)"
    action="$(VCS_INFO_git_getaction "$gitdir")" && action="($action)"
    git_status="$(git status 2> /dev/null)"

    if [[ "$git_status" =~ "(?m)^nothing to" ]]; then
      color="%F{green}"
    elif [[ "$git_status" =~ "(?m)^nothing added" ]]; then
      color="%F{yellow}"
    elif [[ "$git_status" =~ "(?m)^# Untracked" ]]; then
      color="%B%F{red}"
    else
      color="%F{red}"
    fi
    echo " ${color}@${branch_name}${action}%f%b"
  fi
  return 0
}

# http://d.hatena.ne.jp/pasela/20110216/git_not_pushed
function get_git_remote_push() {
  local head remotes x

  # When the current working directory is inside the work tree of the repository print "true", otherwise "false".
  if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == "true" ]]; then
    # Verify that exactly one parameter is provided, and that it can be turned into a raw 20-byte SHA-1 that can be used to access the object database. If so, emit it
    # to the standard output; otherwise, error out.
    head="$(git rev-parse --verify --quite HEAD 2>/dev/null)"
    if [[ $? -eq 0 ]]; then
      remotes=($(git rev-parse --remotes))
      if [[ -n "${remotes[@]}" ]]; then
        for x in ${remotes[@]}; do
          [[ "$head" == "$x" ]] && return 0
        done
        echo " %F{red}@not_pushed%f%b"
      fi
    fi
  fi
  return 0
}

# use pcre-compatible regexp
setopt re_match_pcre
# eval prompt when showing prompt
setopt prompt_subst
# prompt
#PROMPT="[@${HOST%%.*} %1~]%(!.#.$)"
#PROMPT=%n@:%/%%
# %n -> user name
# %m -> hostname
# %~ -> current directory(home directory is ~)
# %(1,#,$)
# %f%b same as %{${reset_color}%}?
PROMPT='%n %F{blue}%~%f%b$(get_git_current_branch)$(get_git_remote_push)'$'\n''%(!,#,$) '

####################
# history
####################

# not history command prefixed with space
setopt hist_ignore_space

# no history history command
setopt hist_no_store

# history file
HISTFILE="${HOME}/.zhistory"

# history file size
HISTSIZE=40000

# saveする量
SAVEHIST=40000

# no memory duplicate history
setopt hist_ignore_dups

# delete unnececally space
setopt hist_reduce_blanks

# share history file
setopt share_history

# automatical register current directory in directory stack
setopt auto_pushd

# not register duplicate directory name in directory stack
setopt pushd_ignore_dups

# history zsh start and end
setopt EXTENDED_HISTORY

# append history file
setopt append_history

####################
# Misc Settings
####################

# editor
if [[ -x "/usr/local/bin/vim" ]]; then
  export EDITOR="/usr/local/bin/vim"
elif [[ -x "/usr/bin/vim" ]]; then
  export EDITOR="/usr/bin/vim"
fi

# load bindkey
if [[ -f "${HOME}/.zsh_bindkey" ]]; then
  source "${HOME}/.zsh_bindkey"
fi

# use zed
autoload zed

# use zmv
autoload zmv
alias zmv="noglob zmv"

# use zargs
autoload zargs

# change directory when entering directory name only
setopt auto_cd

# extended globbing
setopt extended_glob

# sort matched value
setopt numericglobsort

setopt correct

# recognize variable contained abs path as directory name
setopt cdable_vars

# remove rprompt
#setopt transient_rprompt

# display packed list
setopt list_packed

setopt list_types

# not display prompt when completing command
setopt always_last_prompt

# one tab key
#setopt menu_complete

# ignore case-sensitive matches when globbing
#unsetopt case_glob

# match dotted files when globbing
#setopt glob_dots

# sort matched value whne globbing
setopt numeric_glob_sort

# run-help builtin command
# not work?
# [[ -n $(alias run-help) ]] && unalias run-help
# autoload run-help

# add path
if [[ -d "${HOME}/bin" ]]; then
  echo "$PATH" | grep -q "${HOME}/bin" || export PATH="${PATH}:${HOME}/bin"
fi

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
