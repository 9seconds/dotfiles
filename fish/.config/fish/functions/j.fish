#!/usr/bin/env fish

function j -d 'Fast jump in a recent directory'
  cd $(zoxide query --list | 9s-fzf --scheme=path --query=$argv[1])
end
