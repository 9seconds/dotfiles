#!/usr/bin/env fish

if command -q direnv
  direnv hook fish | source
end
