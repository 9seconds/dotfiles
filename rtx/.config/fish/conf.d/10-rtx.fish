#!/usr/bin/env fish

if command -q rtx then
  rtx activate fish | source
  rtx completion fish | source
end
