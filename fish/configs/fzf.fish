#!/usr/bin/env fish
#
# This file contains routines related to fzf.
# https://github.com/junegunn/fzf

if not command -q fzf
    test -d $HOME/.fzf; and fish_add_path $HOME/.fzf/bin
end
not command -q fzf; and exit

set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

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

set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
