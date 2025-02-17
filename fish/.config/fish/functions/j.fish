#!/usr/bin/env fish

function j -d 'Fast jump in a recent directory'
  cd (zoxide query --list \
    | fzf --scheme=path --query=$argv[1] --prompt='branch> ' --height='~30%' --no-separator --info=hidden --no-sort)
end
