ARG BUILD_FROM
FROM $BUILD_FROM

ARG LIBRESPOT_VERSION="0.3.1"

# Add env
ENV LANG C.UTF-8

#Install librespot

RUN apk -U add build-base curl cargo portaudio-dev protobuf-dev

RUN cd /root \
 && curl -LO https://github.com/librespot-org/librespot/archive/refs/tags/v$LIBRESPOT_VERSION.zip \
 && unzip v$LIBRESPOT_VERSION.zip

RUN cd /root/librespot-$LIBRESPOT_VERSION \
 && cargo build --jobs $(grep -c ^processor /proc/cpuinfo) --release --no-default-features \
 && mv target/release/librespot /usr/local/bin \
 && cd / \
 && apk --purge del curl cargo portaudio-dev protobuf-dev \
 && apk add llvm-libunwind \
 && rm -rf /etc/ssl /var/cache/apk/* /lib/apk/db/* /root/v$LIBRESPOT_VERSION.zip /root/librespot-$LIBRESPOT_VERSION /root/.cargo

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
