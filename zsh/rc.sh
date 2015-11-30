
# Initialize shell
source $ZSH_CUSTOM_PATH/init.sh

# Load custom functions
source $ZSH_CUSTOM_PATH/functions.sh

# Load aliases
source $ZSH_CUSTOM_PATH/aliases.sh

# Load key bindings
source $ZSH_CUSTOM_PATH/binds.sh

# Source ah autocompletion
if which ah > /dev/null; then
    source $DEVGOPATH/src/github.com/9seconds/ah/sourceit/zsh.sh
fi

# Use GVM
if [[ -s "$HOME/.gvm/scripts/gvm" ]]; then
    source "$HOME/.gvm/scripts/gvm"
    export GOPATH="$DEVGOPATH:$GOPATH"
fi

# Apply Gruvbox palette
source "$HOME/.config/nvim/plugged/gruvbox/gruvbox_256palette.sh"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD || ag -l -g "") 2> /dev/null'

# Private stuff I do not want to share
[[ -f "$HOME/.zshrc.private" ]] && source "$HOME/.zshrc.private"
