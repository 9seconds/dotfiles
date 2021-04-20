#!/usr/bin/env fish
#
# This is a completion for bd command


function _bd_complete_seen_command -d 'This function checks if we have a parameter provided'
  if test (count (commandline -poc)) -gt 1
    return 0
  end

  return 1
end


function _bd_complete_arg -d 'This function completes bd arguments'
  set -l arg (commandline -ct)

  for dname in (_bd_dirnames)
    set -l bname (basename $dname | string replace -r "^\." "")
    if test -z $arg
        or string match -e -i -q "$arg*" $bname
        echo (printf "%s\t%s" $bname $dname)
    end
  end
end

complete -c bd -f
complete -c bd -n 'not _bd_complete_seen_command' -a '(_bd_complete_arg)'
