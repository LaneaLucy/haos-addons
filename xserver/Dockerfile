ARG BUILD_FROM #=ghcr.io/hassio-addons/debian-base:7.2.0
FROM $BUILD_FROM


# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && \
    DEBIAN_FRONTEND='noninteractive'  apt-get install -y  --no-install-recommends xorg firefox-esr pulseaudio

# Copy root filesystem
COPY rootfs /

