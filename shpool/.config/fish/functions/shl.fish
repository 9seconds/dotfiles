#!/usr/bin/env fish

function shl -d "list shpool sessions"
  shpool list | tail -n +2 | 9fzf --sort --with-nth 1,3 --accept-nth 1 $argv
end
