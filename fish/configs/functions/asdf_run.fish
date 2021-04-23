#!/usr/bin/env fish

function asdf_run -d 'Run a command whithin asdf plugin'
  if test (count $argv) -eq 0
    echo Unknown plugin
    return 1
  end

  set plugin $argv[1]
  if not contains $plugin (asdf plugin list | string trim)
    echo Unknown plugin $plugin
    return 1
  end

  set plugin_version $argv[2]
  if test -z $plugin_version
    set plugin_version latest
  else if not contains $plugin_version (asdf list $plugin | string trim)
    echo Unknown version $plugin_version of plugin $plugin
    return 1
  end

  set argv $argv[3..-1]
  if test (count $argv) -eq 0
    echo Undefined command
    return 1
  end

  fish -P -c "asdf shell $plugin $plugin_version; $argv"
end
