#!/bin/bash
set -eu

exec /usr/local/bin/gosu "$DUID:$DGID" beet "$@"
