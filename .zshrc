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

# go
if [[ -x "$(which go 2>/dev/null)" ]]; then
  export GOPATH="${HOME}/.go"
  [[ -d "${HOME}/.go" ]] || mkdir "${HOME}/.go"
  path=($path ${GOPATH}/bin)
fi

# heroku
path=($path /usr/local/heroku/bin(N-/))

# rsense
path=($path ${HOME}/rsense-0.3/bin(N-/))

# /usr/local/bin
path=(/usr/local/bin(N-/) $path)

# LaTeX
path=($path /usr/local/texlive/2015/bin/x86_64-darwin(N-/))

####################
# Completion
####################

# autoload func path
if type brew &>/dev/null; then
  fpath=($(brew --prefix)/share/zsh/site-functions(N-/) $fpath)
fi
fpath=(${ANTIBODY_HOME}/zsh-users-zsh-completions/src(N-/) $fpath)

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
# antibody
####################

if [[ -x "/usr/local/bin/antibody" ]]; then
  export ANTIBODY_HOME="${HOME}/.antibody"
  [[ -d "$ANTIBODY_HOME" ]] || mkdir "$ANTIBODY_HOME"
  source <(/usr/local/bin/antibody init)

  # too slow
  #antibody bundle zsh-users/zsh-syntax-highlighting
  antibody bundle zsh-users/zsh-history-substring-search
  antibody bundle zsh-users/zsh-completions src
  antibody bundle gunzy83/packer-zsh-completion
  antibody bundle mollifier/anyframe
  antibody bundle Tarrasch/zsh-bd
  antibody bundle soimort/translate-shell
  antibody bundle knakayama/ghq-util
  antibody bundle knakayama/zsh-git-prompt
  antibody bundle knakayama/gopath-util
  antibody bundle knakayama/wacker

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
fi

####################
# PROMPT
####################

# PROMPT  -> left prompt
# RPROMPT -> right prompt
# PROMPT2 -> prompt when displaying 2 line
# SPROMPT -> prompt when entering error command

# enable color prompt
#autoload -U colors; colors
# prompt theme
#autoload -U promptinit; promptinit
# see prompt preview -> prompt -p <theme>
# see current theme -> prompt -c
#prompt walters

# use pcre-compatible regexp
#setopt re_match_pcre
# eval prompt when showing prompt
#setopt prompt_subst

# prompt
# %n -> user name
# %m -> hostname
# %~ -> current directory(home directory is ~)
# %(1,#,$)
# %f%b same as %{${reset_color}%}?
if [[ -n "$SSH_TTY" ]]; then
  _ssh_tty="@$(echo "$SSH_TTY" | grep -oE 's[0-9]+')"
fi
PROMPT='%n${_ssh_tty} %F{blue}%~%f%b $(-zsh-git-prompt)[%?]'$'\n''%(!,#,$) '

####################
# Misc Settings
####################

# locale
if ! [[ "$(locale)" =~ 'en_US\.UTF-8' ]]; then
  export LC_ALL="en_US.UTF-8"
  export LANG="en_US.UTF-8"
fi

# ls color
if [[ "$OSTYPE" =~ "darwin*" ]]; then
  export CLICOLOR=1
fi

# editor
if type nvim &>/dev/null; then
  export EDITOR="nvim"
elif type vim &>/dev/null; then
  export EDITOR="vim"
else
  export EDITOR="vi"
fi

# XDG_CONFIG
export XDG_CONFIG_HOME="${HOME}/.config"

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

# show time command outputs if command executing time exceeds 1 sec
REPORTTIME=1

# auto-fu.zsh
if [[ -f "${HOME}/.zsh/plugin/auto-fu.zsh/auto-fu.zsh" ]]; then
  source "${HOME}/.zsh/plugin/auto-fu.zsh/auto-fu.zsh"
  zle-line-init() {
    auto-fu-init
  }
  zle -N zle-line-init
fi

# w3m
if [[ -x "$(which w3m 2>/dev/null)" ]]; then
  export HTTP_HOME="http://www.google.com"
fi

# direnv
if [[ -x "$(which direnv 2>/dev/null)" ]]; then
  eval "$(direnv hook zsh)"
fi

# nvm
if [[ -f "${HOME}/.nvm/nvm.sh" ]]; then
  source "${HOME}/.nvm/nvm.sh"
fi
if [[ -f "${HOME}/.nvm/bash_completion" ]]; then
  source "${HOME}/.nvm/bash_completion"
fi

# pwd.sh
if [[ -x "$(which pwd.sh 2>/dev/null)" ]]; then
  export PWDSH_SAFE="${HOME}/.pwd.sh.safe"
fi

# prevent duplicate path
if [[ -n "$TMUX" || -n "$SSH_TTY" ]]; then
  # rbenv
  if type rbenv &>/dev/null; then
    eval "$(rbenv init -)"
  fi

  # pyenv
  if type pyenv &>/dev/null; then
    eval "$(pyenv init -)";
    eval "$(pyenv virtualenv-init -)"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  fi

  # plenv
  if type plenv &>/dev/null; then
    eval "$(plenv init -)"
  fi

  # autoload general-env
  if type pyenv &>/dev/null && type pyenv-virtualenv &>/dev/null; then
    if [[ "$(pyenv virtualenvs)" =~ 'general-env' ]]; then
      pyenv activate general-env
    fi
  fi

  # phpbrew
  if [[ -f "${HOME}/.phpbrew/bashrc" ]]; then
    source "${HOME}/.phpbrew/bashrc"
  fi
fi

# awscli
if type brew &>/dev/null && [[ -f "$(brew --prefix)/share/zsh/site-functions/_aws" ]]; then
  source "$(brew --prefix)/share/zsh/site-functions/_aws"
fi

## awsebcli
#if type eb &>/dev/null && [[ -f "$(which python | sed 's/python$/eb_completion\.bash/')" ]]; then
#  source "$(which python | sed 's/python$/eb_completion\.bash/')"
#fi

# workaround:
# set shell environment
if type tmux &>/dev/null && [[ -n "$TMUX" ]]; then
  tmux set-environment -g PATH "$PATH"
fi
