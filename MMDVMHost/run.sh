#!/usr/bin/with-contenv bashio
set -e

CONFIG="/config/MMDVM.ini"

bashio::log.info "Checking configuration..."

# Create config
MMDVM_ini_path=$(bashio::config 'MMDVM_ini_path')

if [ ! -f ${MMDVM_ini_path} ]
then
    ls -alh /dev/tty*
    bashio::log.error "Specified Config file does not exist. Creating default Config. Please edit before next start!"
    cp /MMDVMHost/MMDVM.ini ${MMDVM_ini_path}
    sed -i -e 's%FilePath=.%FilePath=/var/log/mmdvm%g' ${MMDVM_ini_path}
    exit
fi

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
exec /MMDVMHost/MMDVMHost ${MMDVM_ini_path}


#while true; do sleep 2; done




