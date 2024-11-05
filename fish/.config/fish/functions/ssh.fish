#!/usr/bin/env fish

set cmd ssh
if test -n $KITTY_PUBLIC_KEY
  set cmd kitten ssh
end

function ssh -d 'kitty-aware ssh' -w ssh -V cmd
  command $cmd $argv
end
