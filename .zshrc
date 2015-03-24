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
compinit # compinit -uというのもある

zstyle ':completion:*' completer _oldlist _complete

# ファイル名補完をするとき、除外したいパターンを指定
# fignore=(.sh)

# 補完候補がいくつ以上あれば確認メッセージを表示するか
# LISTMAX=20

# cdコマンドの引数に指定したディレクトリが見つからないときは
# この変数に格納されたディレクトリ以下も検索する
cdpath=(~)

# autoloadされるfunctionを検索するpath
fpath=("${HOME}/.zfunc/zsh-completions" $fpath)

# パスを格納する変数や配列に、重複するディレクトリを
# 登録しても自動で削除
typeset -U path cdpath fpath manpath

####################
# PROMPT
####################

# PROMPT -> left prompt
# RPROMPT -> right prompt
# PROMPT2 -> 2行以上のコマンドを入力する際に表示されるプロンプト
# SPROMPT -> コマンドを打ち間違えたときのプロンプト

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

    [[ "$PWD" =~ '/\.git(/.*)?$' ]] && return 0

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
}
# use pcre-compatible regexp
setopt re_match_pcre
# eval prompt when showing prompt
setopt prompt_subst
# prompt
#PROMPT="[@${HOST%%.*} %1~]%(!.#.$)"
#PROMPT=%n@:%/%%
# %n -> user name
# %~ -> current directory(home directory is ~)
# %(1,#,$)
# %f%b same as %{${reset_color}%}?
PROMPT='%n@%m %F{blue}%~%f%b$(get_git_current_branch)'$'\n''%(!,#,$) '

####################
# history
####################

# 茵がスペースで始まるコマンドラインは
# ヒストリに記録しない
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

# cdコマンドだけでディレクトリスタックにpushdする
# cd - [Tab]を押すとディレクトリスタックが表示される
setopt auto_pushd

# ディレクトリスタックに重複するディレクトリを登録しない
setopt pushd_ignore_dups

# zshの開始終了を記録
setopt EXTENDED_HISTORY

# 複数のzshを同時に使う時などにhistoryファイルを上書きせず追加する
setopt append_history

####################
# Plugin
####################

#if [[ -d "${HOME}/.zsh/plugin" ]]; then
#    source ${HOME}/.zsh/plugin/*
#fi

####################
# Misc Settings
####################

# editor
if [[ -x "/usr/bin/vim" ]]; then
    export EDITOR="/usr/bin/vim"
fi

# emacs binding
bindkey -e

# load bindkey
if [[ -f "${HOME}/.zsh_bindkey" ]]; then
    source "${HOME}/.zsh_bindkey"
fi

# pipで一回インストールしたものをもう一度
# インストールしなくても済む
# pip installした時に.pip_cacheが無かったら
# 勝手に作る
if [[ -s "${HOME}/.pip_cache" ]]; then
    export PIP_DOWNLOAD_CACHE="${HOME}/.pip_cache"
fi

# Virtualenvwrapper settings
wrapper_path=$(which virtualenvwrapper.sh 2>/dev/null)
if [[ -x "$wrapper_path" ]]; then
    export WORKON_HOME="${HOME}/.virtualenvs"
    source "$wrapper_path"
else
    unset wrapper_path
fi

##########
# Misc Load Functions
##########

# use zed
autoload zed

# use zmv
autoload zmv
alias zmv="noglob zmv"

# use zargs
autoload zargs

##########
# Misc Set Options
##########

# defaultから変更されたoptionは
# setoptで確認できる
# 現在無効にセットされているoptionは
# unsetoptで確認できる
# 何々optionが有効とno何々optionが無効は同じ意味
# 全てのoptionの設定状態を確認するには
# set -o( | sort)
# optionは大文字小文字_があってもなくても同じ
# optionを無効にするには2つの方法がある
# unsetopt hoge
# setopt nohoge
# コマンドラインから有効無効を変更する
# set -o hoge -> 有効
# set +o hoge -> 無効

# directory名を入力しただけで移動
setopt auto_cd

# extended globbing
setopt extended_glob

# マッチした値をsortする
setopt numericglobsort

setopt correct

# 絶対パスが入った変数をディレクトリと見なす
setopt cdable_vars

# 右側まで入力がきたら時間を消す
#setopt transient_rprompt

# display packed list
setopt list_packed

# 保管一覧ファイル別表示
setopt list_types

# 補完候補を表示するたびにプロンプトを下に表示しない
setopt always_last_prompt

# Tabキーを押す回数を1回分減らす
#setopt menu_complete

# ファイルグロブで大文字小文字を区別しない
#unsetopt case_glob

# ドットで始まるファイルもファイルグロブでマッチさせる
#setopt glob_dots

# ファイルグロブで数値パターンがマッチすれば数値でソートする
setopt numeric_glob_sort

# Esc + hした時に内部コマンドも表示するようにする
# not work?
# [ -n $(alias run-help) ] && unalias run-help
# autoload run-help


# path
if [[ -d "${HOME}/bin" ]]; then
    if ! echo "$PATH" | grep -q "${HOME}/bin"; then
        export PATH="${PATH}:${HOME}/bin"
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

# w3m
if [[ -x "$(which w3m 2>/dev/null)" ]]; then
    export HTTP_HOME="http://www.google.com"
fi

if [[ -x "/usr/local/bin/peco" ]]; then
    # sheet and peco settings
    # http://blog.glidenote.com/blog/2014/06/26/snippets-peco-percol/
    function peco-snippets() {
        local SNIPPETS="$(cat ~/.sheets/* | peco --query "$LBUFFER")"
        zle clear-screen
    }

    zle -N peco-snippets
    bindkey '^x^s' peco-snippets

    # select history
    # http://k0kubun.hatenablog.com/entry/2014/07/06/033336
    #function peco-select-history() {
    #    typeset tac
    #    if which tac > /dev/null 2>&1; then
    #      tac=tac
    #    else
    #      tac='tail -r'
    #    fi
    #    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
    #    CURSOR=$#BUFFER
    #    zle -R -c
    #}
    #zle -N peco-select-history
    #bindkey '^r' peco-select-history
fi

# perlbrew
if [[ -d "${HOME}/perl5/perlbrew/etc/bashrc" ]]; then
    source "${HOME}/perl5/perlbrew/etc/bashrc"
fi

# rbenv
if [[ -d "${HOME}/.rbenv" ]]; then
    if ! echo "$PATH" | grep -q "${HOME}/.rbenv/bin"; then
        export PATH="${PATH}:${HOME}/.rbenv/bin"
        eval "$(rbenv init -)"
    fi
fi

# aws
if [[ -f "${HOME}/bin/aws-cli/bin/aws_zsh_completer.sh" ]]; then
    source "${HOME}/bin/aws-cli/bin/aws_zsh_completer.sh"
fi

# direnv
if [[ -x "/usr/local/bin/direnv" ]]; then
    eval "$(direnv hook zsh)"
fi

# tmuxinator
if [[ -x "${HOME}/bin/tmuxinator/completion/tmuxinator.zsh" ]]; then
    source "${HOME}/bin/tmuxinator/completion/tmuxinator.zsh"
fi

# hub
# not work...
#if [[ -x "${HOME}/bin/hub/etc/hub.zsh_completion" ]]; then
#    source "${HOME}/bin/hub/etc/hub.zsh_completion"
#fi

# go
if [[ -x "/usr/bin/go" ]]; then
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
    fpath=("${HOME}/.zfunc/zsh-completions" "${HOME}/.ghq/github.com/motemen/ghq/zsh" $fpath)
fi

