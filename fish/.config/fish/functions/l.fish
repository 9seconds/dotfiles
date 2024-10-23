#!/usr/bin/env fish

if command -q eza
  set cmd eza --classify --icons --git --hyperlink
  set wraps eza
else
  set cmd ls --hyperlink=auto
  set wraps ls
end

function l -d 'list files' -w $wraps -V cmd
  command $cmd $argv
end
