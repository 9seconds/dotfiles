#!/usr/bin/env fish

set -gx LESS -RFXS

if command -q bat
  set -gx LESSOPEN "| "(command -v bat)" -pp --color=always %s"
else if command -q pygmentize
  set -gx LESSOPEN "| "(command -v pygmentize)" -f terminal %s"
else if command -q lesspipe
  set -gx LESSOPEN "| "(command -v lesspipe)" %s"
  set -gx LESSCLOSE (command -v lesspipe)" %s %s"
end
