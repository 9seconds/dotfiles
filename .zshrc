###############################################################################
# ZSH Header
###############################################################################

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="9seconds"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# How many hundreds of seconds to wait before start to manage next keystroke
KEYTIMEOUT=1

# Set proper TERM for tmux
if [ -n "$TMUX" ]; then
    export TERM=screen-256color
else
    export TERM=xterm-256color
fi

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(docker brew pyenv python pip taskwarrior vagrant gitfast git-extras autojump colorize sudo command-not-found)

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

function docker_images() {
    docker images | egrep -v "REPOSITORY|<none>" | awk '{print $1}' | sort -u
}

function docker_update() {
    docker images | egrep -v "REPO|<none>" | awk '{print $1}' | sort -u | xargs -P 2 -n 1 docker pull -a
}

function docker_stop() {
    docker stop $(docker ps -a -q)
}

function docker_clean() {
    docker_stop
    docker rm $(docker ps -a -q)
    docker images | grep "<none>" | awk '{print $3}' | xargs docker rmi
}

function docker_rmi() {
    for repo in "$@"; do
        docker images | grep "$repo" | awk '{print $2}' | xargs -n 1 -I {} docker rmi "$repo:{}"
    done
}

function aptg() {
    sudo apt-get -qq -y update && \
    sudo apt-get -y dist-upgrade && \
    sudo apt-get -qq -y autoremove && \
    sudo apt-get -qq clean
}



###############################################################################
# Environment variables
###############################################################################

export DEVPATH=$HOME/dev
export DEV3PPPATH=$DEVPATH/3pp
export DEVVIRTUALENVPATH=$DEVPATH/.virtualenvs
export DEVPVTPATH=$DEVPATH/pvt
export DEVWRKPATH=$DEVPATH/wrk

export DEVEXPERIMENTSPATH=$DEVPATH/experiments
export DEVGOPATH=$DEVPATH/gopath

export GOPATH=$DEVGOPATH
export GOBIN=$GOPATH/bin
export WORKON_HOME=$DEVVIRTUALENVPATH

export EDITOR=vim
export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python"
export VIRTUAL_ENV_DISABLE_PROMPT=1
export HISTTIMEFORMAT="%d.%m.%y %H:%M:%S"
export PYENV_ROOT=$HOME/.linuxbrew/opt/pyenv

export PATH=$HOME/.linuxbrew/bin:$PATH
export PATH=$PATH:$GOBIN
export PATH=:$HOME/.local/bin:$PATH
export PATH=$PATH::$HOME/.gem/ruby/current/bin
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"

export HOMEBREW_TEMP=$HOME/.linuxbrew/tmp



###############################################################################
# Custom configuration
###############################################################################

unsetopt nomatch

if which dircolors > /dev/null; then
	alias ls='ls --color=auto -F'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward


virtualenvwrapper='virtualenvwrapper.sh'
if (( $+commands[$virtualenvwrapper] )); then
      source ${${virtualenvwrapper}:c}
fi


###############################################################################
# Aliases
###############################################################################

alias ag='ag --color -fS'
alias catc="colorize"
alias df='df -ah --total'
alias du='du -ahc'
alias g=git
alias grep=egrep
alias gst='g st'
alias h=ah
alias hl='h l'
alias hsg='h s -g'
alias hs='h s'
alias ht='h t --'
alias htx='h t -x --'
alias hty='h t -y --'
alias mkdir='mkdir -pv'
alias netstat='netstat -anp'
alias pxargs='xargs -P $(nproc)'
alias reset='reset && source ~/.zshrc'
alias tailf='tail -f'
alias ta='t --all'
alias ta='tig -a'
alias t=tig
alias vg='vim -g'
alias vless='vim -R -c "set number" -u /usr/share/vim/vim74/macros/less.vim'
alias v=vim

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



###############################################################################
## Colorscheme
################################################################################

BASE16_SCHEME="tomorrow"
BASE16_SHELL="$DEV3PPPATH/base16-shell/base16-$BASE16_SCHEME.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL



###############################################################################
## Misc
################################################################################

source $DEVGOPATH/src/github.com/9seconds/ah/sourceit/zsh.sh



###############################################################################
## Private stuff I do not want to share
################################################################################

[[ -f $HOME/.zshrc.private ]] && source $HOME/.zshrc.private
