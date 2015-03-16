#!/usr/bin/env zsh

# Initialize shell
source $ZSH_CUSTOM_PATH/init.sh

# Load custom functions
source $ZSH_CUSTOM_PATH/functions.sh

# Load aliases
source $ZSH_CUSTOM_PATH/aliases.sh

# Load key bindings
source $ZSH_CUSTOM_PATH/binds.sh

# Colorscheme
source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

# Source ah autocompletion
if which ah > /dev/null; then
    source $DEVGOPATH/src/github.com/9seconds/ah/sourceit/zsh.sh
fi

# Use GVM
if [[ -s "$HOME/.gvm/scripts/gvm" ]]; then
    source "$HOME/.gvm/scripts/gvm"
    export GOPATH="$DEVGOPATH:$GOPATH"
fi

# Private stuff I do not want to share
[[ -f "$HOME/.zshrc.private" ]] && source "$HOME/.zshrc.private"
