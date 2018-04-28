FROM alpine:3.7

ENTRYPOINT ["/usr/bin/beet", "--config", "/beets.yaml"]
EXPOSE 80
ENV EDITOR=vim
WORKDIR "/work"

RUN set -x \
  && echo 'http://dl-cdn.alpinelinux.org/alpine/v3.7/community' >> /etc/apk/repositories \
  && echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
  && apk --update upgrade \
  && apk add \
    ca-certificates \
    chromaprint \
    ffmpeg \
    flac \
    g++ \
    gst-plugins-bad \
    gst-plugins-base \
    gst-plugins-good \
    gst-plugins-ugly \
    gstreamer \
    imagemagick \
    lame \
    liboggz \
    libvorbis \
    make \
    py3-gst \
    py3-pillow \
    python3 \
    vim \
    vorbis-tools \
    wavpack \
  && pip3 --no-cache-dir --disable-pip-version-check install \
    'beets[fetchart,chroma,web,import,thumbnails,lastgenre]' \
    beautifulsoup4 \
    langdetect \
  && mkdir /tmp/mp3val /tmp/oggz \
  && wget -O - 'https://datapacket.dl.sourceforge.net/project/mp3val/mp3val/mp3val%200.1.8/mp3val-0.1.8-src.tar.gz' \
    | tar zxf - -C /tmp/mp3val \
  && cd /tmp/mp3val/mp3val-0.1.8-src \
  && make -f Makefile.linux \
  && install -m 755 -s mp3val /usr/local/bin/mp3val \
  && apk del --rdepends \
    g++ \
    make \
  && rm -r /var/cache/apk/* /tmp/mp3val \
  && mkdir /.cache /.config \
  && chmod 777 /.cache /.config \
  && ln -s /usr/lib/libpython3.6m.so.1.0 /usr/lib/libpython3.6m.so
