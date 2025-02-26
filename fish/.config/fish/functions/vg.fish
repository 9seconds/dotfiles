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
     | fzf \
        -0 \
        --sort \
        --ansi \
        --scheme=path \
        --delimiter=: \
        --with-nth '{1}:{2}  {4..}' \
        --nth=1,4.. \
        --info=hidden \
        --prompt='filter> ' \
        --no-multi \
        --filepath-word \
        --with-shell='bash -c' \
        --preview='lineno={2} && start_range=$((lineno > 20 ? lineno-20 : 1)) && bat -p -r ${start_range}:$((lineno+20)) -H $lineno --color=always {1}' \
        --bind 'ctrl-n:preview-down,ctrl-p:preview-up,ctrl-d:preview-page-down,ctrl-u:preview-page-up,shift-up:half-page-up,shift-down:half-page-down' \
     | awk -F: '{print "+"$2, $1}' \
     | xargs -r -o nvim
end
