#!/usr/bin/env fish

if command -q mise then
  set -x MISE_JOBS (nproc)
  mise activate fish | source
end
