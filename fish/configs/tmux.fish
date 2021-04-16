#!/usr/bin/env fish
#
# This file contains everything related to tmux
# https://github.com/tmux/tmux

not command -q tmux; and exit

set -q TMUX; and set -gx TERM tmux-256color
