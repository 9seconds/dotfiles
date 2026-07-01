#!/usr/bin/env fish

if command -q ag
  set -gx FZF_DEFAULT_COMMAND 'ag --nocolor --nogroup -l -g ""'
end

if command -q rg
  set -gx FZF_DEFAULT_COMMAND 'rg --files'
end

if command -q fdfind
  set -gx FZF_DEFAULT_COMMAND 'fdfind --type f --strip-cwd-prefix --hidden --follow --exclude .git'
end

if command -q fd
  set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
end

set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
