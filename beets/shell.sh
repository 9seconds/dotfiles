#!/bin/bash

beet_update() {
  local repo_path="$HOME/dev/pvt/dotfiles/beets"

  docker image build \
      --squash \
      --pull \
      --compress \
      --rm \
      --file "$repo_path/Dockerfile" \
    "$repo_path"
}

beet () {
  local uid="$(id -u)"
  local gid="$(id -g)"

  docker run \
      --rm \
      --interactive \
      --tty \
      --workdir="/work" \
      -e "DUID=$uid" \
      -e "DGID=$gid" \
      -e "TZ=Europe/Moscow" \
      -v "$HOME/.beets:/config" \
      -v "$HOME/test:/music" \
      -v "$(pwd):/work:ro" \
      -v "/etc/group:/etc/group:ro" \
      -v "/etc/shadow:/etc/shadow:ro" \
      -v "/etc/passwd:/etc/passwd:ro" \
      -v "$HOME/dev/pvt/dotfiles/beets/config.yaml:/config/config.yaml:ro" \
    beets "$@"
}
