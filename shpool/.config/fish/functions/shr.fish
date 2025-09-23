#!/usr/bin/env fish

function shr -d "kill shpool sessions"
  shl -m | xargs shpool kill
end
