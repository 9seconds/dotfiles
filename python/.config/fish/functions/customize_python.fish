#!/usr/bin/env fish

function customize_python -d 'Modify virtualenv usercustomize'
  if test (count $argv) -ne 1
    echo Specify a python executable 1>&2
    return 1
  end

  if not test -x $argv[1]
    echo Not a python executable 1>&2
    return 1
  end

  ln -sf "$PYTHONSTARTUP" ($argv[1] -m site --user-site)/usercustomize.py
end
