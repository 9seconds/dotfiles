#!/usr/bin/env fish

function __9s_last_history -d 'Return a latest history item'
  history --max 1
end

function __9s_logfile -d 'Add a tee prefix'
  set line (commandline -j | iconv -t ascii//TRANSLIT)
  set line (string trim -- $line)
  set line (string replace -r -a '[^0-9a-zA-Z]' '-' -- $line)
  set line (string shorten -c '' -m 10 -N -- $line)

  echo (string join '-' $line (date +%s) (xxd -l 8 -p /dev/random) ".log")
end


abbr --add -- gs g s
abbr --add -- gdf g df
abbr --add --position anywhere --set-cursor -- L "% | less"
abbr --add --position anywhere --function __9s_last_history -- !!
abbr --add --position anywhere --function __9s_logfile -- LF
