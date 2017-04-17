#!/usr/bin/env zsh

# Common aliases
alias clc="noglob clc"
alias df="df -ah --total"
alias grep=egrep
alias makep="make -j $(cpu_count)"
alias mkdir="mkdir -pv"
alias netstat="netstat -anp"
alias pxargs="xargs -P $(cpu_count)"
alias reset="reset && resource"
alias resource="source $ZSHRC"
alias tailf="tail -f"

# Tool related aliases
if which pygmentize > /dev/null; then
    alias catc="pygmentize -f terminal256 -O style=native -g"
fi

if which vim > /dev/null; then
    alias v=vim
    alias vi=vim
    alias vg="vim -g"
    alias vless="vim -R -c "set number" -u /usr/share/vim/vim74/macros/less.vim"
fi

if which nvim > /dev/null; then
    alias nv=nvim
    alias v=nvim
    alias vim=nvim
fi

if which git > /dev/null; then
    alias g=git
    alias gst="g st"
    alias gdf="g df"
fi

if which tig > /dev/null; then
    alias t=tig
    alias ta="t --all"
fi

if which xsel > /dev/null; then
    alias ccopy="xsel --clipboard --input"
    alias cpaste="xsel --clipboard --output -o"
fi

# Alises with color support
if which dircolors > /dev/null; then
    alias ag="ag --color -fS"
	alias ls="ls --color=auto -F"
	alias grep="grep --color=auto"
	alias fgrep="fgrep --color=auto"
	alias egrep="egrep --color=auto"
fi

# Global aliases
alias -g AG="| ag"
alias -g B="&|"
alias -g CA="2>&1 | cat -A"
alias -g DEVNULL="> /dev/null 2>&1"
alias -g G="| grep"
alias -g HL="--help"
alias -g LL="2>&1 | less -XSFR"
alias -g L="| less -XSFR"
alias -g NE="2> /dev/null"
alias -g ST="2>&1"
alias -g TEE="2>&1 | tee"
alias -g V="| view -"
