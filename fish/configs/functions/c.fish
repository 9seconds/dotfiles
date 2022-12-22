#!/usr/bin/env fish

not command -q chore; and exit

function c -d 'chore' -w chore
  command chore $argv
end
