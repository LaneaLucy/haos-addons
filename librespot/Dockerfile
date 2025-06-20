ARG BUILD_FROM
FROM $BUILD_FROM

ARG LIBRESPOT_VERSION="0.6.0"

# Add env
ENV LANG C.UTF-8

#Install librespot

RUN apk -U add build-base curl cargo portaudio-dev protobuf-dev cmake clang17-libclang avahi-dev avahi-compat-libdns_sd ca-certificates

RUN cd /root \
 && curl -LO https://github.com/librespot-org/librespot/archive/refs/tags/v$LIBRESPOT_VERSION.zip \
 && unzip v$LIBRESPOT_VERSION.zip

#RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

#RUN source $HOME/.cargo/env \
# && rustup component add rustfmt \
# && rustup component add clippy

#RUN export PATH="$HOME/.cargo/bin:$PATH" && rustup-init

RUN cargo install --force --locked bindgen-cli

RUN cd /root/librespot-$LIBRESPOT_VERSION \
 && export PATH="$HOME/.cargo/bin:$PATH" \
 && cargo build --jobs $(grep -c ^processor /proc/cpuinfo) --release --no-default-features  \
 && mv target/release/librespot /usr/local/bin \
 && cd / \
 && apk --purge del curl cargo portaudio-dev protobuf-dev cmake clang17-libclang \
 && apk add llvm-libunwind \
 && rm -rf /etc/ssl /var/cache/apk/* /lib/apk/db/* /root/v$LIBRESPOT_VERSION.zip /root/librespot-$LIBRESPOT_VERSION /root/.cargo

# Copy data for add-on
COPY rootfs /
#COPY run.sh /
#RUN chmod a+x /run.sh

#CMD [ "/run.sh" ]


