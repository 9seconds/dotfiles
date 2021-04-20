#!/usr/bin/env fish
#
# This is a script for jumping back to some parent directory

function bd -d 'Jump back to some directory'
  set -l parameter (string replace -r "^\." "" $argv[1])

  if test (count $argv) -gt 0
    for name in (_bd_dirnames)
      set -l bname (basename $name | string replace -r "^\." "")
      if string match -e -i -q "$parameter*" $bname
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
