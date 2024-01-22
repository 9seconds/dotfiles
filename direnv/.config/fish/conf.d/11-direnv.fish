#!/usr/bin/env fish

fish_add_path $HOME/.local/share/mise/shims

if command -q direnv
  direnv hook fish | source
end
