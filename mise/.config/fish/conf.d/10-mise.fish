#!/usr/bin/env fish

if command -q mise then
  if test (uname) = "Darwin"
    set -x MISE_JOBS (sysctl -n hw.physicalcpu)
  else
    set -x MISE_JOBS (nproc)
  end

  mise activate fish | source
end
