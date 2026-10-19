#!/usr/bin/env fish

function cdr -d 'Jump to the repository root'
  set -l root (git rev-parse --show-toplevel 2>/dev/null)
  if test -n "$root"
    cd "$root"
  end
end
