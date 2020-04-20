FROM linuxserver/beets:amd64-latest

ENV EDITOR=vim

RUN set -x \
  && apk add --no-cache vim

ADD https://github.com/tianon/gosu/releases/download/1.12/gosu-amd64 /usr/local/bin/gosu

RUN set -x \
  && chmod +x /usr/local/bin/gosu

COPY docker-entrypoint.sh /entry

ENTRYPOINT ["/entry"]
