#!/usr/bin/env fish

function gmt -d "Global mise tasks" -w "mise tasks"
  mise -C $HOME/.local/share/mise/global-dir tasks $argv
end
