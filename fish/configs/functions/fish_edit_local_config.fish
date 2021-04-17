#!/usr/bin/env fish
#
# This file opens editor for a local config.

function fish_edit_local_config -d 'Edit local config'
  command $EDITOR $HOME/.local-config.fish; and source $HOME/.local-config.fish
end
