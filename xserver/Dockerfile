ARG BUILD_FROM #=ghcr.io/hassio-addons/debian-base:7.2.0
FROM $BUILD_FROM


# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && \
    DEBIAN_FRONTEND='noninteractive'  apt-get install -y  --no-install-recommends xorg python3-dev firefox-esr pulseaudio ffmpeg

RUN wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py --break-system-packages

# Copy root filesystem
COPY rootfs /

