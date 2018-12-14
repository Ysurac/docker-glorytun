FROM alpine:3.8

RUN apk add --no-cache iproute2 meson build-base gcc libsodium-dev

# Add the glorytun launch script
ADD glorytun.sh /usr/sbin/glorytun.sh

# Glorytun commit
ENV commit 067ddd4aa04dbb628463666a90b7dcf3cd6963c9
WORKDIR /tmp
RUN git clone https://github.com/angt/glorytun.git \
    && cd glorytun \
    && git checkout ${commit} \
    && meson build && ninja -C build install \
    && rm -rf /tmp/glorytun \
    && apk del meson build-base gcc
CMD /usr/sbin/glorytun.sh
