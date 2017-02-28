# Custom configuration for ZSH environment

# Disable global completion init
skip_global_compinit=1


# Environment
export PATH="/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

export ZSH_CUSTOM_PATH="$HOME/.zsh"
export ZSH="$ZSH_CUSTOM_PATH/oh-my-zsh"
export ZSH_CUSTOM="$ZSH_CUSTOM_PATH/custom"
export ZSHRC="$HOME/.zshrc"

export DEVPATH="$HOME/dev"
export DEV3PPPATH="$DEVPATH/3pp"
export DEVVIRTUALENVPATH="$DEVPATH/.virtualenvs"
export DEVPVTPATH="$DEVPATH/pvt"
export DEVWRKPATH="$DEVPATH/wrk"
export DEVEXPERIMENTSPATH="$DEVPATH/experiments"
export DEVGOPATH="$DEVPATH/gopath"

export LISTDIR="$HOME/.config/lists"

export GOPATH="$DEVGOPATH"
export GOBIN="$GOPATH/bin"
export WORKON_HOME="$DEVVIRTUALENVPATH"

export EDITOR=nvim
export VIMRC="$HOME/.vimrc"
export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python"
export VIRTUAL_ENV_DISABLE_PROMPT=1
export HISTTIMEFORMAT="%d.%m.%y %H:%M:%S"
export PYENV_ROOT="$HOME/.pyenv"
export PYTHONSTARTUP="${HOME}/.pythonrc"

export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.fzf/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.node_prefix/bin:$PATH"
export PATH="$GOBIN:$PATH"

export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export RUST_SRC_PATH=$HOME/dev/3pp/rust/src
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'

export VAGRANT_DEFAULT_PROVIDER=libvirt

# Set proper TERM for tmux
if [ -n "$TMUX" ]; then
    export TERM=tmux-256color
else
    export TERM=xterm-256color
fi
