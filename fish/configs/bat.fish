#!/usr/bin/env fish
#
# This file contains settings for bat
# https://github.com/sharkdp/bat

if command -q bat
  set -gx BAT_THEME gruvbox-dark
  set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
  set -gx MANROFFOPT -c
end
