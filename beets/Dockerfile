FROM linuxserver/beets:amd64-latest

RUN set -x \
  && apk add --no-cache vim \
  && pip3 install --no-cache-dir beets-bandcamp

ENV EDITOR=vim

ADD https://github.com/tianon/gosu/releases/download/1.12/gosu-amd64 /usr/local/bin/gosu

RUN set -x \
  && chmod +x /usr/local/bin/gosu \
  && echo "#!/bin/bash" >> /entry \
  && echo 'exec /usr/local/bin/gosu "$DUID:$DGID" beet "$@"' >> /entry \
  && chmod +x /entry

ENTRYPOINT ["/entry"]
