
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

# Apply Gruvbox palette
#if [[ -f "$HOME/.config/nvim/plugged/gruvbox/gruvbox_256palette.sh" ]]; then
#    source "$HOME/.config/nvim/plugged/gruvbox/gruvbox_256palette.sh"
#else
#    source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"
#fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD || ag -l -g "") 2> /dev/null'

# KeyChain
if which keychain > /dev/null; then
    eval $(keychain --nocolor --eval --agents ssh,gpg id_rsa 2> /dev/null)
fi

# Private stuff I do not want to share
[[ -f "$HOME/.zshrc.private" ]] && source "$HOME/.zshrc.private"
