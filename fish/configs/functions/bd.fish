#!/usr/bin/env fish
#
# This is a script for jumping back to some parent directory

function bd -d 'Jump back to some directory'
  if test (count $argv) -gt 0
    for name in (_bd_dirnames)
      if string match -q -i -e -r ".*?(?:$argv[1]).*?" (basename $name)
        cd $name
        return 0
      end
    end

    echo Cannot find a matching directory
    return 1
  end

  if not command -q fzf
    echo Cannot find fzf to run bd without arguments
  end

  cd (_bd_dirnames | fzf)
end

function _bd_dirnames -d 'Extract dirnames from the current path'
  set current_dir (realpath -s $PWD)

  while test -n $current_dir
      and test $current_dir != "/"
    echo $current_dir
    set current_dir (dirname $current_dir)
  end
end
