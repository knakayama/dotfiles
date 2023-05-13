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

path=(
  ${HOME}/bin(N-/)
  /opt/homebrew/bin(N-/)
  ${HOME}/.poetry/bin/poetry(N-/)
  ${HOME}/.local/bin(N-/)
  /opt/homebrew/opt/unzip/bin(N-/)
  /opt/homebrew/opt/curl/bin(N-/)
  ${HOME}/.krew/bin
  $path
)

if type go &>/dev/null; then
  export GOBIN="$(go env GOPATH)/bin"
  path=("$GOBIN" $path)
fi

####################
# Completion
####################

fpath=(
  $(brew --prefix)/share/zsh/site-functions(N-/)
  ${ANTIBODY_HOME}/zsh-users-zsh-completions/src(N-/)
  ${HOME}/.zsh/completions(N-/)
  ${HOME}/.zfunc(N-/)
  ${HOME}/.zsh/functions(N-/)
  $fpath
)

# zsh functions
function() {
  local file
  for file in ${HOME}/.zsh/functions/*(N-.); do
    local func_name="${file:t}"
    autoload -Uz -- "$func_name"
    zle -N -- "$func_name"
  done
}

# enable completion
autoload bashcompinit
bashcompinit
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

if type antibody &>/dev/null; then
  export ANTIBODY_HOME="${HOME}/.antibody"
  [[ -d "$ANTIBODY_HOME" ]] || mkdir "$ANTIBODY_HOME"
  source <($(brew --prefix antibody)/bin/antibody init)

  # too slow
  #antibody bundle zsh-users/zsh-syntax-highlighting
  antibody bundle zsh-users/zsh-history-substring-search
  antibody bundle zsh-users/zsh-completions src
  antibody bundle gunzy83/packer-zsh-completion
  antibody bundle mollifier/anyframe
  antibody bundle Tarrasch/zsh-bd
  antibody bundle knakayama/ghq-util
  antibody bundle knakayama/zsh-git-prompt
  antibody bundle knakayama/gopath-util

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
if [[ -n "$AWS_SESSION_TOKEN" ]]; then
  _aws="aws"
fi

source "$(brew --prefix)/opt/kube-ps1/share/kube-ps1.sh"
KUBE_PS1_SYMBOL_ENABLE=false
KUBE_PS1_DIVIDER="|"
PROMPT='%n${_ssh_tty}$([[ -n "$AWS_SESSION_TOKEN" ]] && echo %{$fg_bold[red]%}@aws%{${reset_color}%}) %F{blue}%~%f%b $(-zsh-git-prompt)$(kube_ps1)[%?]'$'\n''%(!,#,$) '

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
if type vim &>/dev/null; then
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

# direnv
if type direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

# npm completion
if type npm &>/dev/null; then
  source <(npm completion)
fi

if type rtx &>/dev/null; then
  eval "$(rtx activate zsh)"
fi

if type terraform &>/dev/null; then
  complete -o nospace -C terraform terraform
fi

if type aws-vault &>/dev/null; then
  eval "$(aws-vault --completion-script-zsh)"
fi

if type kind &>/dev/null; then
  source <(kind completion zsh)
fi

if type kubectl &>/dev/null; then
  source <(kubectl completion zsh)
fi

if kubectl krew &>/dev/null; then
  source <(kubectl krew completion zsh)
fi

if type helm &>/dev/null; then
  source <(helm completion zsh)
fi

if [[ -f "${HOME}/.work.env" ]]; then
  source "${HOME}/.work.env"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
