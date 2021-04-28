#!/usr/bin/env fish
#
# This file contains all settings related to less

set -gx LESS -RFXS

if command -q lesspipe
  set cmd -l (command -s lesspipe)
  set -gx LESSOPEN "| $cmd %s"
  set -gx LESSCLOSE "$cmd %s %s"
end

if command -q pygmentize
  set -l cmd (command -s pygmentize)
  set -gx LESSOPEN "| $cmd -f terminal %s"
  set -ge LESSCLOSE
end

if command -q bat
  set -l cmd (command -s bat)
  set -gx LESSOPEN "| $cmd -p --color=always %s"
  set -ge LESSCLOSE
end
