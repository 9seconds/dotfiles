#!/usr/bin/env fish

function sha -d "shpool attach"
  shl --exit-0 --select-1 | xargs -r -n 1 shpool attach
end
