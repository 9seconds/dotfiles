#!/usr/bin/env fish

if type -q fd
  fd --change-older-than 2weeks . ~/.local/state/9seconds/_cache | xargs -n 50 rm -rf
end
