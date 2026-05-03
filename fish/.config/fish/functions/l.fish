#!/usr/bin/env fish

set cmd ls
set wraps ls

switch (uname)
  case Darwin
    set cmd ls
  case '*'
    set cmd ls --hyperlink=auto
end

if command -q eza
  set cmd eza --classify --icons --git --hyperlink
  set wraps eza
end

function l -d 'list files' -w $wraps -V cmd
  $cmd $argv
end
