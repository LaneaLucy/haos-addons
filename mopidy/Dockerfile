ARG BUILD_FROM #=ghcr.io/hassio-addons/debian-base:7.2.0
FROM $BUILD_FROM


# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
RUN \
    apt-get update \
    \
    && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        gir1.2-gstreamer-1.0 \
        gir1.2-gst-plugins-base-1.0 \
        gstreamer1.0-plugins-good \
        gstreamer1.0-plugins-ugly \
        gstreamer1.0-tools \
        python3-dev \
        python3-gi \
        python3-gst-1.0 \
        libgstreamer1.0-dev \
        libgstreamer-plugins-base1.0-dev \
        gcc pkg-config wget

RUN wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py --break-system-packages \
    \
    && python3 -m pip install --break-system-packages mopidy

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN source "$HOME/.cargo/env" \
    && git clone --depth 1 https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs \
    && cd gst-plugins-rs \
    && cargo build --package gst-plugin-spotify --release \
    && install -m 644 target/release/libgstspotify.so $(pkg-config --variable=pluginsdir gstreamer-1.0)/

RUN find /usr/local \
      \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
      -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
      -exec rm -rf '{}' + \
    \
    && apt-get purge -y --auto-remove \
        build-essential \
        gcc \
        python-dev \
        dpkg-dev \
        wget \
    && rm -fr \
        /var/{cache,log}/* \
        /var/lib/apt/lists/* \
        /root/.cache \
    && find /tmp/ -mindepth 1  -delete

# Copy root filesystem
COPY rootfs /

