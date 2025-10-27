#!/usr/bin/env fish

function mkex -d 'Create directory for experiments'
  set -g _mkex_origin $PWD
  set -gx MKEX_DIR $(mktemp -d)
  echo "Experiments: $MKEX_DIR"
  cd $MKEX_DIR

  function done
    cd $_mkex_origin
    rm -rf $MKEX_DIR
    functions -e done
    set -e MKEX_DIR
    set -e _mkexp_origin
    return 0
  end
end
