#!/usr/bin/env fish

function _asdf_run_needs_plugin_completion -d 'Checks if we need to complete plugin now'
  if test (count (commandline -poc)) -eq 1
      and test -z (commandline -ct)
    return 0
  end

  return 1
end


function _asdf_run_needs_version_completion -d 'Checks if we need to complete version now'
  if test (count (commandline -poc)) -eq 2
    return 0
  end

  return 1
end


function _asdf_run_needs_command_completion -d 'Checks if we need to complete command now'
  if test (count (commandline -poc)) -ge 3
    set tokens (commandline -poc) (commandline -ct)
    return 0
  end

  return 1
end


function _asdf_run_plugin_list -d 'List available plugins'
  asdf plugin list | sort
end


function _asdf_run_plugin_version -d 'List available plugin versions'
  set args (commandline -poc)

  asdf list $args[2] | string trim | sort -V
end

function _asdf_run_plugin_command -d 'Get autocompletion for a command'
  set tokens (commandline -poc) (commandline -ct)
  set tokens $tokens[4..-1]

  complete -C"$tokens"
end

complete -c asdf_run -f
complete -c asdf_run -n _asdf_run_needs_plugin_completion -a '(_asdf_run_plugin_list)'
complete -c asdf_run -n _asdf_run_needs_version_completion -a '(_asdf_run_plugin_version)'
complete -c asdf_run -n _asdf_run_needs_command_completion -F -a '(_asdf_run_plugin_command)'
