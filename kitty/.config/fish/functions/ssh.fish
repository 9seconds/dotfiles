#!/usr/bin/env fish

function ssh -w ssh -d 'kitten ssh wrapper'
  if not set -q SSH_CONNECTION
    kitten ssh $argv
  else
    command ssh $argv
  end
end
