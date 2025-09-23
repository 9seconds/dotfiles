#!/usr/bin/env fish

function shd -d "shpool detach"
  if set -q SHPOOL_SESSION_NAME
    shpool detach
  end
end
