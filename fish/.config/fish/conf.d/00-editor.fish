#!/usr/bin/env fish

set -gx EDITOR vim

if command -q nvim
  set -gx EDITOR nvim
end
