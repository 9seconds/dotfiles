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

# taken from
# https://github.com/Aejkatappaja/cendre/blob/main/extras/fzf/cendre-medium.sh
set -gxa FZF_DEFAULT_OPTS --color=bg+:#26211f
set -gxa FZF_DEFAULT_OPTS --color=bg:#1d1917
set -gxa FZF_DEFAULT_OPTS --color=border:#3d3633
set -gxa FZF_DEFAULT_OPTS --color=fg:#a09384
set -gxa FZF_DEFAULT_OPTS --color=fg+:#e6d5c2
set -gxa FZF_DEFAULT_OPTS --color=gutter:#1d1917
set -gxa FZF_DEFAULT_OPTS --color=header:#4e89a2
set -gxa FZF_DEFAULT_OPTS --color=hl:#ea9875
set -gxa FZF_DEFAULT_OPTS --color=hl+:#fcba81
set -gxa FZF_DEFAULT_OPTS --color=info:#73665b
set -gxa FZF_DEFAULT_OPTS --color=marker:#43b16a
set -gxa FZF_DEFAULT_OPTS --color=pointer:#ea9875
set -gxa FZF_DEFAULT_OPTS --color=prompt:#d1766e
set -gxa FZF_DEFAULT_OPTS --color=query:#e6d5c2
set -gxa FZF_DEFAULT_OPTS --color=scrollbar:#3d3633
set -gxa FZF_DEFAULT_OPTS --color=separator:#3d3633
set -gxa FZF_DEFAULT_OPTS --color=spinner:#ea9875
