#!/usr/bin/env zsh

# Common aliases
alias catc="pygmentize -g"
alias df="df -ah --total"
alias du="du -ahc"
alias gdf="g df"
alias g=git
alias grep=egrep
alias gst="g st"
alias h=ah
alias hl="h l"
alias hsg="h s -g"
alias hs="h s"
alias ht="h t --"
alias htx="h t -x --"
alias hty="h t -y --"
alias mkdir="mkdir -pv"
alias netstat="netstat -anp"
alias nv=nvim
alias pxargs="xargs -P $(cpu_count)"
alias reset="reset && resource"
alias resource="source $ZSHRC"
alias tailf="tail -f"
alias ta="t --all"
alias t=tig
alias vg="vim -g"
alias vi=vim
alias vless="vim -R -c "set number" -u /usr/share/vim/vim74/macros/less.vim"
alias v=vim

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
