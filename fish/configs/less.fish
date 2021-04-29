#!/usr/bin/env fish
#
# This file contains all settings related to less

set -gx LESS -RFXS

if command -q bat
  set -gx LESSOPEN "| "(command -s bat)" -pp --color=always %s"
else if command -q pygmentize
  set -gx LESSOPEN "| "(command -s pygmentize)" -f terminal %s"
else if command -q lesspipe
  set -gx LESSOPEN "| "(command -s lesspipe)" %s"
  set -gx LESSCLOSE (command -s lesspipe)" %s %s"
end
