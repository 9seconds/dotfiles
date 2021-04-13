set -gx PATH $HOME/.fzf/bin $PATH

if command -q nvim
  set -gx EDITOR nvim
else
  set -gx EDITOR vim
end

if command -q pyenv
  pyenv init - | source
  status --is-interactive; and source (pyenv virtualenv-init -|psub)
end

if command -q ag
  set -gx FZF_DEFAULT_COMMAND 'ag --nocolor --nogroup -l -g ""'
end

if command -q rg
  set -gx FZF_DEFAULT_COMMAND 'rg --files'
end

if command -q fdfind
  set -gx FZF_DEFAULT_COMMAND 'fdfind --type f --hidden --follow --exclude .git'
end

if command -q fd
  set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
end

if set -q TMUX
  set -gx TERM tmux-256color
end

set -gx BAT_THEME 'gruvbox'
set -gx NVIM_TUI_ENABLE_TRUE_COLOR 1
set -gx PYENV_VIRTUALENV_DISABLE_PROMPT 1
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx COLORTERM truecolor
set -gx VIMRC $HOME/.vimrc
set -gx PYTHONSTARTUP $HOME/.pythonrc

alias grep egrep
alias mkdir 'mkdir -pv'
alias g git
alias gs 'git s'
alias gdf 'git df'
alias v vim

if command -q tig
  alias t tig
  alias ta 'tig --all'
end

if status --is-interactive
  theme_gruvbox dark medium
end

set pure_symbol_prompt '➜'
set pure_symbol_git_unpulled_commits '⇣'
set pure_symbol_git_unpushed_commits '⇡'

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
