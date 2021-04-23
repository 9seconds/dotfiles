#!/usr/bin/env fish
#
# This file contains everything related to zoxide
# https://github.com/ajeetdsouza/zoxide

if command -q zoxide
  zoxide init fish | source
end
