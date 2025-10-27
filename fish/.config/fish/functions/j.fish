#!/usr/bin/env fish

function j -d 'Fast jump in a recent directory'
  cd $(zoxide query --list | _fzf --scheme=path --query=$argv[1])
end
