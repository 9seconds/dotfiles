#!/usr/bin/env fish


function __9last_history -d 'Return a latest history item'
  history --max 1
end

function __9logfile -d 'Generate a name for a logfile'
  set line (commandline -jo | iconv -t ascii//TRANSLIT)
  set prefix ""

  if [ $line[-1] = "LF" ]
    set line $line[..-2]
  end

  set line (string trim -- $line)
  set line (string replace -r -a '[^0-9a-zA-Z]' '-' -- $line)
  set line (string shorten -c '' -m 10 -N -- $line)
  set prefix (string join '-' -- $line)-

  printf {$prefix}(date +%s)-(xxd -l 8 -p /dev/random).log
end

function __9gitroot -d 'Show git root'
  git rev-parse --show-toplevel 2>/dev/null
  or printf GR
end

abbr --add -- gs  g s
abbr --add -- gdf g df
abbr --add --position anywhere --set-cursor                 -- L  "% &| less"
abbr --add --position anywhere                              -- T  "&| tee"
abbr --add --position anywhere --function __9last_history   -- !!
abbr --add --position anywhere --function __9gitroot        -- GR
abbr --add --position anywhere --function __9s_logfile      -- LF
