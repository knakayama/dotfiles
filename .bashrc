# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# colon seperated list of exact commands to ignore for storing in history
# export HISTIGNORE="clear:bg:fg:cd"

# cd miss-spell outo-completion
shopt -s cdspell

# 複数行に分かれているコマンドラインを、1つのヒストリとして
# 保存する
shopt -s cmdhist

# append to the history file, don't overwrite it
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# alias
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
fi

# enable programmable completion features 
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# same as above
if [ -d /etc/bash_completion.d/ ]; then
    for completion in /etc/bash_completion.d/*; do
        . $completion
    done
fi


# history
export HISTFILESIZE=40000
export HISTFILE=$HOME/.bash_history
export HISTSIZE=40000

# prompt
workdir="\[\e[34m\]\w\[\e[m\]"
PS0="\u@\h $workdir\\$ "
PS1="\u $workdir\\$ "
unset workdir

# editor
# for C-xC-e
if [ -x /usr/bin/vim ]; then
    export EDITOR=/usr/bin/vim
fi

# perlbrew
# source /home/g009c1148/perl5/perlbrew/etc/bashrc

# perl-completion
# complete -C perldoc-complete -o nospace -o default perldoc

# bashDirB
#if [ -s $HOME/.bashDirB ]; then
#    source $HOME/.bashDirB
#fi

# rvm
# enable rvm command
# if [ -s $HOME/.rvm/scripts/rvm ]; then
#    source $HOME/.rvm/scripts/rvm
# fi

# pythonbrew
#if [ -s $HOME/.pythonbrew/etc/bashrc ]; then
    #source $HOME/.pythonbrew/etc/bashrc
#fi
