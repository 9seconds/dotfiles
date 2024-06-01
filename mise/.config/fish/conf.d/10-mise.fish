#!/usr/bin/env fish

if command -q mise then
  mise activate fish | source
  mise completions fish | source
end
