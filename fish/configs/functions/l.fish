#!/usr/bin/env fish

if command -q exa
  set cmd exa --classify --icons --git
  set wraps exa
else
  set cmd ls
  set wraps ls
end

function l -d 'list files' -w $wraps -V cmd
  command $cmd $argv
end
