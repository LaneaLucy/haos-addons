ARG BUILD_FROM #=ghcr.io/hassio-addons/debian-base:7.2.0
FROM $BUILD_FROM


# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
RUN apt-get update && DEBIAN_FRONTEND='noninteractive'  apt-get install -y  --no-install-recommends \
        build-essential \
        git \
        python3-dev \
        wget curl

RUN wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py --break-system-packages 



RUN python3 -m pip install --break-system-packages streamlink

RUN apt-get update && DEBIAN_FRONTEND='noninteractive'  apt-get install -y  --no-install-recommends \
    xorg firefox-esr pulseaudio ffmpeg

# Copy root filesystem
COPY rootfs /

