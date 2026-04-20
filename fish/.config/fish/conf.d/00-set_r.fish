#!/usr/bin/env fish
# vim: set ft=fish sw=2 et sws=2 ts=2

function __9seconds_set_r --on-variable PWD
  set -f inside (git rev-parse --is-inside-work-tree 2>/dev/null)

  if test (count $inside) -eq 1; and $inside[1] = "true"
    set -g R (git rev-parse --show-toplevel 2>/dev/null)
  else
    set -gu R
  end
end

__9seconds_set_r
