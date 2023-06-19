#!/usr/bin/bash

#collect info from wpa_cli -i wlan0 status
WPA_STATE=`wpa_cli -i wlan0 status | grep wpa_state | sed 's/wpa_state=//g'`
SSID=`wpa_cli -i wlan0 status | grep ^ssid | sed 's/ssid=//g'`
IP_ADDR=`wpa_cli -i wlan0 status | grep ip_address | sed 's/ip_address=//g'`

echo wpa_state=$WPA_STATE ssid=$SSID ip=$IP_ADDR

#tests
if [ "$WPA_STATE" == "COMPLETED" ]; then
    echo "WPA_STATE=COMPLETED"
else
    echo "WPA_STATE not COMPLETED"
fi

if [ "$SSID" == "DIRECT-RPi4" ]; then
    echo "SSID=DIRECT-RPi4"
else
    echo "SSID not DIRECT-RPi4"
fi




