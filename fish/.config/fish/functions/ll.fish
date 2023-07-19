#!/usr/bin/env fish

if command -q exa
  set cmd exa --classify --icons --git --long --binary --header
  set wraps exa
else
  set cmd ls -lh
  set wraps ls
end

function ll -d 'list files' -w $wraps -V cmd
  command $cmd $argv
end
