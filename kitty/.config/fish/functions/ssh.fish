#!/usr/bin/env fish

function ssh -d 'kitten ssh' -w ssh
  command kitten ssh $argv
end
