#!/usr/bin/env fish

function cdr -d 'Go to the root of the repository'
  if test $(git rev-parse --is-inside-work-tree 2>/dev/null) = 'true'
    cd $(git rev-parse --show-toplevel)
  end
end
