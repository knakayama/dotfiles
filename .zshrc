####################
# key binding
####################

# emacs binding
bindkey -e

# default keybinding is ^X^F
bindkey '^]' 'vi-find-next-char'
bindkey '^[^]' 'vi-find-prev-char'

####################
# Alias
####################
if [[ -f "${HOME}/.zsh_alias" ]]; then
  source "${HOME}/.zsh_alias"
fi

####################
# path
####################

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
if [[ -x "$(which go)" ]]; then
  export GOPATH="${HOME}/go/vendor"
  [[ -d "${HOME}/go" ]] || mkdir "${HOME}/go"
  path=($path ${GOPATH}/bin)
fi

# heroku
path=($path /usr/local/heroku/bin(N-/))

# rsense
path=($path ${HOME}/rsense-0.3/bin(N-/))

####################
# Completion
####################

# autoload func path
if [[ -x "$(which brew 2>/dev/null)" ]]; then
  fpath=($(brew --prefix)/share/zsh/site-functions(N-/) $fpath)
fi

# original zsh completions
fpath=(${HOME}/.zsh/completions(N-/) $fpath)

# zsh functions
fpath=(${HOME}/.zsh/functions(N-/) $fpath)
function() {
  local file
  for file in ${HOME}/.zsh/functions/*(N-.); do
    local func_name="${file:t}"
    autoload -Uz -- "$func_name"
    zle -N -- "$func_name"
  done
}

# enable completion
autoload -Uz compinit
compinit # also compinit -u

zstyle ':completion:*' completer _oldlist _complete
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# specify ignored patterns whene completing
# fignore=(.sh)

# specify confirm message when completing
# LISTMAX=20

#cdpath=(~)

autoload -Uz add-zsh-hook

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
#PROMPT='%n %F{blue}%~%f%b$(get_git_current_branch)$(get_git_remote_push)'$'\n''%(!,#,$) '
PROMPT='%n %F{blue}%~%f%b $(-git-status)[%?]'$'\n''%(!,#,$) '

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
setopt hist_ignore_all_dups

# delete unnececally space
setopt hist_reduce_blanks

# share history file
setopt share_history

# history zsh start and end
setopt EXTENDED_HISTORY

# append history file
setopt append_history

####################
# cd
####################

# change directory when entering directory name only
setopt auto_cd

# automatical register current directory in directory stack
setopt auto_pushd

# not register duplicate directory name in directory stack
setopt pushd_ignore_dups

# cdr
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 200

####################
# antigen
####################

if [[ -f "${HOME}/.zsh/plugin/antigen.zsh/antigen.zsh" ]]; then
  source "${HOME}/.zsh/plugin/antigen.zsh/antigen.zsh"

  # too slow
  #antigen bundle zsh-users/zsh-syntax-highlighting
  antigen bundle zsh-users/zsh-history-substring-search
  antigen bundle zsh-users/zsh-completions src
  antigen bundle gunzy83/packer-zsh-completion
  antigen bundle mollifier/anyframe
  antigen bundle Tarrasch/zsh-bd
  antigen bundle knakayama/fuc
  antigen bundle knakayama/gzp
  antigen bundle knakayama/ghq-util
  antigen bundle knakayama/zsh-git-prompt
  antigen bundle knakayama/antigen-bundle-record-moving
  antigen apply

  # zsh-users/zsh-history-substring-search
  bindkey -M emacs '^P' history-substring-search-up
  bindkey -M emacs '^N' history-substring-search-down

  # mollifier/anyframe settings
  zstyle ":anyframe:selector:" use peco
  if [[ -f "${HOME}/.peco_config.json" ]]; then
    zstyle ":anyframe:selector:peco:" command "peco --rcfile=${HOME}/.peco_config.json"
  fi

  bindkey '^xr' anyframe-widget-execute-history
  bindkey '^xi' anyframe-widget-put-history
  bindkey '^xg' anyframe-widget-cd-ghq-repository
  bindkey '^x^b' anyframe-widget-checkout-git-branch
  bindkey '^xe' anyframe-widget-insert-git-branch
  bindkey '^xt' anyframe-widget-tmux-attach
  bindkey '^xb' anyframe-widget-cdr

  bindkey '^x^x' fuc-widget-execute-fuc
  bindkey '^x^i' fuc-widget-put-fuc
  export FUC_PATH="${HOME}/.ghq/github.com/knakayama/my-fuc"

  bindkey '^x^g' gzp-widget-open-repo
  bindkey '^x^w' gzp-widget-open-starred

  bindkey '^x^a' -antigen-bundle-record-moving
fi

####################
# Misc Settings
####################

# ls color
if [[ "$OSTYPE" =~ "darwin*" ]]; then
  export CLICOLOR=1
fi

# editor
if type vim >/dev/null 2>&1; then
  export EDITOR="vim"
else
  export EDITOR="vi"
fi

# use zed
autoload zed

# use zmv
autoload zmv
alias zmv="noglob zmv"

# use zargs
autoload zargs

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

# auto-fu.zsh
if [[ -f "${HOME}/.zsh/plugin/auto-fu.zsh/auto-fu.zsh" ]]; then
  source "${HOME}/.zsh/plugin/auto-fu.zsh/auto-fu.zsh"
  function zle-line-init() {
    auto-fu-init
  }
  zle -N zle-line-init
fi

# w3m
if [[ -x "$(which w3m)" ]]; then
  export HTTP_HOME="http://www.google.com"
fi

# perlbrew
if [[ -d "${HOME}/perl5/perlbrew/etc/bashrc" ]]; then
  source "${HOME}/perl5/perlbrew/etc/bashrc"
fi

# direnv
if [[ -x "$(which direnv)" ]]; then
  eval "$(direnv hook zsh)"
fi

# nvm
if [[ -f "${HOME}/.nvm/nvm.sh" ]]; then
  source "${HOME}/.nvm/nvm.sh"
fi
if [[ -f "${HOME}/.nvm/bash_completion" ]]; then
  source "${HOME}/.nvm/bash_completion"
fi

# pyenv
if type pyenv &>/dev/null; then
  eval "$(pyenv init -)";
fi

# phpbrew
if [[ -f "${HOME}/.phpbrew/bashrc" ]]; then
  source "${HOME}/.phpbrew/bashrc"
fi

## aws
#if type brew >/dev/null 2>&1 && [[ -f $(brew --prefix)/share/zsh/site-functions/_aws ]]; then
#  source "$(brew --prefix)/share/zsh/site-functions/_aws"
#fi

# boot2docker
if type boot2docker >/dev/null 2>&1 && [[ "$(boot2docker status)" == "running" ]]; then
  eval "$(boot2docker shellinit 2>/dev/null)"
fi
