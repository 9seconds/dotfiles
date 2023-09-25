#!/usr/bin/env fish

if command -q eza
  set cmd eza --classify --icons --git
  set wraps eza
else
  set cmd ls
  set wraps ls
end

function l -d 'list files' -w $wraps -V cmd
  command $cmd $argv
end
