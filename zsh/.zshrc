#
# Antigen
#

source "$HOME/.zsh/antigen/antigen.zsh"

antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
  autojump
  command-not-found
  docker
  gitfast
  pip
  ssh-agent

  zsh-users/zsh-syntax-highlighting
EOBUNDLES

antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship

antigen apply

#
#  zshenv
#

export ZSHRC="$HOME/.zshrc"
export VIMRC="$HOME/.vimrc"
export PYENV_ROOT="$HOME/.pyenv"
export PYTHONSTARTUP="${HOME}/.pythonrc"

export HISTTIMEFORMAT="%d.%m.%y %H:%M:%S"

export PATH="/snap/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.fzf/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.node_prefix/bin:$PATH"

export EDITOR=nvim

export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'
export VAGRANT_DEFAULT_PROVIDER=libvirt
export SPACESHIP_PROMPT_TRUNC=0
export SPACESHIP_TIME_SHOW=true
export SPACESHIP_NVM_SHOW=false
export SPACESHIP_RUBY_SHOW=false
export SPACESHIP_SWIFT_SHOW_LOCAL=false
export SPACESHIP_XCODE_SHOW_LOCAL=false
export SPACESHIP_XCODE_SHOW_GLOBAL=false
export SPACESHIP_DOCKER_SHOW=false
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# Set proper TERM for tmux
if [ -n "$TMUX" ]; then
    export TERM=tmux-256color
else
    export TERM=xterm-256color
fi

# Initialize shell
# source "$ZSH_CUSTOM_PATH/init.sh"

# Load custom functions
source "$HOME/.zsh/functions.sh"

# Load aliases
source "$HOME/.zsh/aliases.sh"

# Load key bindings
source "$HOME/.zsh/binds.sh"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='(ag --nocolor --nogroup -l -g "") 2> /dev/null'

# Private stuff I do not want to share
[[ -f "$HOME/.zshrc.private" ]] && source "$HOME/.zshrc.private"
