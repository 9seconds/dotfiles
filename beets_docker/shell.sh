#!/bin/sh


beet_rebuild () {
  docker build \
      --pull \
      --squash \
      --tag beets \
    $HOME/dev/pvt/dotfiles/beets_docker
}

beet () {
  docker run \
      --rm \
      --interactive \
      --tty \
      -v "$HOME/dev/pvt/dotfiles/beets_docker/config.yaml:/beets.yaml:ro" \
      -v "$HOME/.beets.db:/beets.db:rw" \
      -v "$(pwd):/work:rw" \
      -v "/Volumes/MusicBackup:/music:rw" \
    beets "$@"
}
