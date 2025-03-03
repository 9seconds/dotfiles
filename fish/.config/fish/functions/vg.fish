#!/usr/bin/env fish

if command -q nvim
  set editor nvim
else
  set editor vim
end

if command -q rg
  set search rg \
    --no-messages \
    --smart-case \
    --vimgrep \
    --glob="!{.git,.svn,node_modules,__pycache__}" \
    --hyperlink-format=none \
    --color=always
else if git rev-parse --is-inside-work-tree >/dev/null 2>&1
  set search git grep -n
else
  set search grep -n
end

function vg -d "open files in vim"
  $search $argv \
     | 9fzf \
        --sort \
        --scheme=path \
        --delimiter=: \
        --with-nth '{1}:{2}  {4..}' \
        --nth=1,4.. \
        --prompt='filter> ' \
        --filepath-word \
        --preview='lineno={2} && start_range=$((lineno > 20 ? lineno-20 : 1)) && bat -p -r ${start_range}:$((lineno+20)) -H $lineno --color=always {1}' \
     | awk -F: '{print "+"$2, $1}' \
     | xargs -r -o nvim
end
