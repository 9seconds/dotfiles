#!/usr/bin/env fish

set cmd ls --hyperlink=auto
set wraps ls

if command -q eza
  set cmd eza --classify --icons --git --hyperlink
  set wraps eza
end

function l -d 'list files' -w $wraps -V cmd
  $cmd $argv
end
