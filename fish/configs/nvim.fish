#!/usr/bin/env fish
#
# This file contains everything related to Neovim
# https://github.com/neovim/neovim

not command -q nvim; and exit

set -gx EDITOR nvim
set -gx NVIM_TUI_ENABLE_TRUE_COLOR 1
set -gx COLORTERM truecolor
set -gx VIMRC $HOME/.config/nvim/init.vim
