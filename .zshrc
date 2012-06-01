####################
# Alias
####################
if [ -f $HOME/.zsh_aliases ]; then
    source $HOME/.zsh_aliases
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
fpath=($fpath $HOME/.zfunc)

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

# color format
# %{${fg[文字色]}${bg[背景色]%}}
# sample
# %{${fg[blue]}%} %~ %{${fg[green]}%}%# %{${fg[black]}%}
# 文字色を青         文字色を緑         文字色を黒

# enable color prompt
autoload -U colors
colors

# prompt theme
autoload -U promptinit
promptinit
# see prompt preview -> prompt -p <theme>
# see current theme -> prompt -c
#prompt walters

# prompt
#PROMPT="[@${HOST%%.*} %1~]%(!.#.$)"
#PROMPT=%n@:%/%%
# %n -> user name
# %~ -> current directory(home directory is ~)
# %(1,#,$)
PROMPT="%n %{${fg[blue]}%}%~%{${reset_color}%}%(!,#,$) "

####################
# history
####################

# 行頭がスペースで始まるコマンドラインは
# ヒストリに記録しない
setopt hist_ignore_space

# no history history command
setopt hist_no_store

# history file
HISTFILE=~/.zhistory

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

if [ -d $HOME/.zsh/plugin ]; then
    source $HOME/.zsh/plugin/*
fi

####################
# Misc Settings
####################

# editor
export EDITOR=/usr/bin/vim

# emacs binding
bindkey -e

# load bindkey
if [ -f $HOME/.zsh_bindkey ]; then
    source $HOME/.zsh_bindkey
fi

# pipで一回インストールしたものをもう一度
# インストールしなくても済む
# pip installした時に.pip_cacheが無かったら
# 勝手に作る
if [ -s $HOME/.pip_cache ]; then
    export PIP_DOWNLOAD_CACHE=$HOME/.pip_cache
fi

# Virtualenvwrapper settings
if [ -f "${HOME}/.virtualenvs" ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/bin/virtualenvwrapper.sh
fi

##########
# Misc Load Functions
##########

# use zed
autoload zed

# use zmv
autoload zmv
alias zmv='noglob zmv'

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

# convenient
setopt prompt_subst

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

