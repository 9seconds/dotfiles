#!/usr/bin/fish

not command -q dircolors; exit

test -r $HOME/.dir_colors; eval (dircolors -c $HOME/.dir_colors)
