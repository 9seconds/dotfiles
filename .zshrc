###############################################################################
# ZSH Header
###############################################################################

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="arrow"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(gitfast git-extras jsontools python autojump command-not-found docker)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"


###############################################################################
# Custom functions
###############################################################################

tstamp () {
    # Converts unix timestamp into the date
    if [ $# -ne 1 ]
    then
        echo "Usage: tstamp <unix timestamp>"
        return 1
    fi
    echo "$1" | gawk '{print strftime("%c", ( $0 + 500 ) / 1000 )}'
}

function find() {
    # Some optimizations for find
    /usr/bin/find -L -O3 $@
}

function ffind() {
    # Find only files with some optimizations I generally use
    find $@ -type f
}

function dfind() {
    # Find only files with some optimizations I generally use
    find $@ -type d
}

function portu() {
    # Prints who occupied port
    if [ $# -ne 1 ]
    then
        echo "Usage: portu <port number>"
        return 1
    fi
    sudo netstat -lnp | ag "$1" | gawk '{print $4,"\t",$7}'
}


###############################################################################
# Custom configuration
###############################################################################

unsetopt nomatch

if which dircolors > /dev/null; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto -F'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

eval `dircolors ~/.dir_colors`

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export VIRTUAL_ENV_DISABLE_PROMPT=1
export EDITOR=vim

bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo


###############################################################################
# Aliases
###############################################################################

alias v=vim
alias g=git
alias t=tig
alias ta='t --all'
alias tmux='TERM=xterm-256color tmux -2'
alias gst='g st'
alias ffind=ffind
alias dfind=dfind
alias grep=egrep
alias mkdir='mkdir -pv'
alias ag='ag --color -fS'
alias vless='vim -R -c "set number" -u /usr/share/vim/vim74/macros/less.vim'
alias df='df -ah --total'
alias du='du -ahc'
alias pxargs='xargs -P $(nproc)'
alias portu=portu
alias aptg="sudo apt-get -qq -y update && sudo apt-get -y dist-upgrade"

alias -g G="| grep"
alias -g L="| less -XSFR"
alias -g V="| view -"
alias -g ST="2>&1"
alias -g TEE="2>&1 | tee"
alias -g B="&|"
alias -g HL="--help"
alias -g LL="2>&1 | less -XSFR"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"

export GOPATH=$HOME/dev/experiments/collectors
export PATH=$PATH:$HOME/.local/bin:$HOME/.gem/ruby/1.9.1/bin
# export GOROOT=$HOME/dev/.go/collectors
# export GOPATH=$GOROOT
# export GOBIN=$GOROOT/bin
# export GOARCH=amd64
# export GOOS=linux
# export PATH=$GOBIN:$PATH


###############################################################################
## Private stuff I do not want to share
################################################################################

if [ -f ~/.zshrc.private ]; then
    . ~/.zshrc.private
fi
