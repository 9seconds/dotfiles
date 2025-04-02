#!/usr/bin/env fish

function gmtr -d "Run global mise tasks" -w "mise tasks run"
  mise -C $HOME/.local/share/mise/global-dir tasks run $argv
end
