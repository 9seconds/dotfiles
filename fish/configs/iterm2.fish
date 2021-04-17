#!/usr/bin/env fish
#
# This file contains everything related to iterm2
# https://iterm2.com/

if test -e $HOME/.iterm2_shell_integration.fish
    and test (string lower $LC_TERMINAL) = 'iterm2'
  source $HOME/.iterm2_shell_integration.fish
end
