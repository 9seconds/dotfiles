#!/usr/bin/env fish

if command -q mise then
  mise activate fish | source
  mise completion fish | source
end
