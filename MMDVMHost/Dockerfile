ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.1.0
FROM $BUILD_FROM



WORKDIR /

# install dependencies for compiling
RUN apk add --update \
    make \
    git \
    g++ \
    linux-headers \
    python3



# get and install MMDVMHost
RUN git clone https://github.com/g4klx/MMDVMHost.git \
    && cd /MMDVMHost && make

# get MMDVMHost-Dashboard
RUN git clone https://github.com/dg9vh/MMDVMHost-Dashboard.git 

RUN python -c 'import sys;s=open(sys.argv[1]).read().replace("\\\n", "");open(sys.argv[1], "w").write(s)' /MMDVMHost-Dashboard/ajax.php \
    && python -c 'import sys;s=open(sys.argv[1]).read().replace("\\\n", "");open(sys.argv[1], "w").write(s)' /MMDVMHost-Dashboard/txinfo.php
    

#RUN docker-php-ext-install intl \
#    && docker-php-ext-install gettext

# clean
RUN apk del make git linux-headers python3 \
    && rm -rf /var/cache/apk/*



# configure for MMDVMHost
RUN addgroup -g 1000 mmdvm \
    && adduser -u 1000 -G mmdvm -s /bin/sh -D mmdvm \
    && adduser mmdvm audio \
    && chown -R mmdvm:mmdvm /MMDVMHost \
    && mkdir /var/log/mmdvm \
    && chown -R mmdvm:mmdvm /var/log/mmdvm

# install dependencies for MMDVMHost-Dasboard (http server + php)
RUN apk add --update lighttpd \
    php81-gettext \
    php81-common \
    php81-iconv \
    php81-json \
    php81-gd \
    php81-curl \
    php81-xml \
    php81-simplexml \
    php81-pgsql \
    php81-imap \
    php81-cgi \
    fcgi \
    php81-pdo \
    php81-pdo_pgsql \
    php81-soap \
    php81-posix \
    php81-gettext \
    php81-ldap \
    php81-ctype \
    php81-dom \
    php81-fpm \
    && mkdir -p /var/www/html/

# ensure www-data user exists
RUN set -eux; \
    adduser -u 82 -D -S -G www-data www-data
# 82 is the standard uid/gid for "www-data" in Alpine
# https://git.alpinelinux.org/aports/tree/main/apache2/apache2.pre-install?h=3.14-stable
# https://git.alpinelinux.org/aports/tree/main/lighttpd/lighttpd.pre-install?h=3.14-stable
# https://git.alpinelinux.org/aports/tree/main/nginx/nginx.pre-install?h=3.14-stable



# configure MMDVMHost-Dasboard
RUN cp -R /MMDVMHost-Dashboard/* /var/www/html/

COPY config.php /var/www/html/config/config.php

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 1777 /var/www/html



COPY run.sh /
COPY MMDVM.ini /MMDVMHost/MMDVM.ini
COPY lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY etc/* /etc/
RUN chmod a+x /run.sh



WORKDIR /MMDVMHost
USER mmdvm

CMD ["/run.sh"]
