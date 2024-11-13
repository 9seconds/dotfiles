#!/usr/bin/env fish

function kssh -d 'Install kitty files to remote machine'
  infocmp -a xterm-kitty | ssh $argv[1] -- tic -x -o \~/.terminfo /dev/stdin
end
