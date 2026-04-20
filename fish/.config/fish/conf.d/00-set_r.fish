#!/usr/bin/env fish
# vim: set ft=fish sw=2 et sws=2 ts=2

function __9seconds_set_r --on-variable PWD
  set -g R (git rev-parse --show-toplevel 2>/dev/null)
  or set -gu R
end

__9seconds_set_r
