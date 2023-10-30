#!/usr/bin/with-contenv bashio
set -e

CONFIG="/MMDVMHost/MMDVM.ini"

bashio::log.info "Creating configuration..."

# Create config
MMDVM_INI=$(bashio::config 'MMDVM_ini')

#echo ${MMDVM_INI} > "${CONFIG}"

#cat "${CONFIG}"

#bashio::log.debug ${MMDVM_INI}



if [ "$(bashio::config 'show_ls')" ]
then
	ls -alh /dev/tty*
fi


#php-fpm81 -D
#lighttpd -f /etc/lighttpd/lighttpd.conf

# Start DHCP server
bashio::log.info "Starting MMDVMHost..."
exec /MMDVMHost/MMDVMHost ${CONFIG}


#while true; do sleep 2; done




