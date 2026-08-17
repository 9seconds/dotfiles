#!/usr/bin/env fish

function gwt -d 'Just to another working tree'
  if git rev-parse --is-inside-work-tree &>/dev/null
    cd $(git wt ls | 9s-fzf --nth 1 --accept-nth 2 '--prompt=working tree> ')
  end
end
