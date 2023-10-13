#!/command/with-contenv bashio

declare device
declare device_type
declare temperature_scale
device=$(bashio::config 'device')
device_type=$(bashio::config 'device_type')
temperature_scale=$(bashio::config 'temperature_scale')

if  bashio::var.equals "${device_type}" "fake"; then
    bashio::log.info "Configuring fake device"
    sed -i "s/%%device%%/FAKE = DS18B20,DS2405/g" /etc/owfs.conf
elif bashio::var.equals "${device_type}" "usb"; then
    bashio::log.info "Configuring usb device"
    sed -i "s/%%device%%/usb = all/g" /etc/owfs.conf
else
    bashio::log.info "Configuring ${device} device"
    device=$(bashio::string.replace ${device} '/' '\/')
    sed -i "s/%%device%%/device = ${device}/g" /etc/owfs.conf
fi

bashio::log.info "Configuring temperature scale: ${temperature_scale}"
sed -i "s/%%temperature_scale%%/${temperature_scale}/g" /etc/owfs.conf
