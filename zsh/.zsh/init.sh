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
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'
export VAGRANT_DEFAULT_PROVIDER=libvirt
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export FZF_DEFAULT_COMMAND='(ag --nocolor --nogroup -l -g "") 2> /dev/null'

export PURE_PROMPT_SYMBOL="➜"

# Set proper TERM for tmux
if [ -n "$TMUX" ]; then
    export TERM=tmux-256color
else
    export TERM=xterm-256color
fi
