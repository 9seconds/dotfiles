#!/usr/bin/env fish

if command -q just
  just --completions fish | source
end
