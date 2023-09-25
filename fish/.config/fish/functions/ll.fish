#!/usr/bin/env fish

if command -q eza
  set cmd eza --classify --icons --git --long --binary --header
  set wraps eza
else
  set cmd ls -lh
  set wraps ls
end

function ll -d 'list files' -w $wraps -V cmd
  command $cmd $argv
end
