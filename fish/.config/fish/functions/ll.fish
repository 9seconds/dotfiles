#!/usr/bin/env fish

set cmd ls -lh
set wraps ls

if command -q eza
  set cmd eza --classify --icons --git --long --binary --header
  set wraps eza
end

function ll -d 'list files' -w $wraps -V cmd
  command $cmd $argv
end
