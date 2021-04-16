#!/usr/bin/env fish
#
# This file contains everything related to Fish theme

if status --is-interactive
    and functions -q theme_gruvbox
  theme_gruvbox dark medium
end
