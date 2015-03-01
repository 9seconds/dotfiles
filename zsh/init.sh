###############################################################################
# OH MY ZSH CONFIGURATION
###############################################################################

# ZSH theme
ZSH_THEME="9seconds"

# Use case sensitive completions.
CASE_SENSITIVE="true"

# Disable terminal auto title.
DISABLE_AUTO_TITLE="true"

# Show red dots on long completions
COMPLETION_WAITING_DOTS="true"

# How many hundreds of seconds to wait before start to manage next keystroke
KEYTIMEOUT=1

# ZSH syntax highlighters
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

# List of ZSH plugins
plugins=(
    docker
    vagrant
    gitfast
    autojump
    sudo
    command-not-found
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh



###############################################################################
# SHELL CONFIGURATION
###############################################################################

eval "$(pyenv init -)"

unsetopt nomatch

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

virtualenvwrapper='virtualenvwrapper.sh'
if (( $+commands[$virtualenvwrapper] )); then
      source ${${virtualenvwrapper}:c}
fi
