FROM alpine:3.8

RUN apk add --no-cache iproute2 meson build-base gcc libsodium-dev

# Add the glorytun launch script
ADD glorytun.sh /usr/sbin/glorytun.sh

# Glorytun version 0.0.99-mud
ENV version 0.0.99-mud
WORKDIR /tmp
ADD https://github.com/angt/glorytun/releases/download/v${version}/glorytun-${version}.tar.gz /tmp/glorytun-${version}.tar.gz
RUN tar xzf /tmp/glorytun-${version}.tar.gz
WORKDIR /tmp/glorytun-${version}
RUN meson build && ninja -C build install
RUN rm -rf /tmp/glorytun-${version}
RUN apk del meson build-base gcc
CMD /usr/sbin/glorytun.sh
