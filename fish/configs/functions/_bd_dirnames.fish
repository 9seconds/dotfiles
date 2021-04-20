#!/usr/bin/env fish
#
# This is a helper function for bd command. This is also required for
# completion that's why it is extracted here.

function _bd_dirnames -d 'Extract dirnames from the current path'
  set current_dir (dirname (realpath $PWD))

  while test -n $current_dir
      and test $current_dir != "/"
    echo $current_dir
    set current_dir (dirname $current_dir)
  end
end
