# enable color support of ls and also add handly aliases
if [ -x /bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls="ls --color=auto"
    alias dir="dir --color=auto"
    alias vdir="vdir --color=auto"

    alias grep="grep --color=auto"
    alias fgrep="fgrep --color=auto"
    alias egrep="egrep --color=auto"
fi

# ls aliases
alias ll="ls -l"
alias la="ls -A"
alias lla="ls -lA"
alias l="ls -CF"
alias lld="ls -ld"

# other aliases
alias ..="cd .."
# kesanai
alias crontab="crontab -i"
# less.sh is vi like less command
#alias vless="/usr/share/vim/vim71/macros/less.sh"

# open perl module by vim
alias vipm="PERLDOC_PAGER=vim perldoc -m $@"
