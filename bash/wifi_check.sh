#!/usr/bin/bash

#collect info from wpa_cli -i wlan0 status
#WPA_STATE=`wpa_cli -i wlan0 status | grep wpa_state | sed 's/wpa_state=//g'`
#SSID=`wpa_cli -i wlan0 status | grep ^ssid | sed 's/ssid=//g'`
#IP_ADDR=`wpa_cli -i wlan0 status | grep ip_address | sed 's/ip_address=//g'`

#echo wpa_state=$WPA_STATE ssid=$SSID ip=$IP_ADDR

#tests
#if [ "$WPA_STATE" == "COMPLETED" ]; then
#    echo "WPA_STATE=COMPLETED"
#else
#    echo "WPA_STATE=$WPA_STATE"
#fi

#if [ "$SSID" == "DIRECT-RPi4" ]; then
#    echo "SSID=DIRECT-RPi4"
#else
#    echo "SSID=$SSID"
#fi


#if [ ! -z `echo $IP_ADDR | grep 192.168.49` ]; then
#    echo "L'IP=$IP_ADDR contient bien 192.168.49"
#else
#    echo "L'IP=$IP_ADDR ne contient pas 192.168.49"
#fi

#boucle check WPA_STATE = COMPLETED
while :
do
	WPA_STATE=`wpa_cli -i wlan0 status | grep wpa_state | sed 's/wpa_state=//g'`
	echo "WPA_STATE=$WPA_STATE"
	if [ "$WPA_STATE" == "COMPLETED" ]; then
		break
	fi
	echo "WPA_STATE pas COMPLETED on sleep 1s"
	sleep 1
done


#boucle check SSID = DIRECT-RPi4
while :
do
	SSID=`wpa_cli -i wlan0 status | grep ^ssid | sed 's/ssid=//g'`
	echo "SSID=$SSID"
	if [ "$SSID" == "DIRECT-RPi4" ]; then
		break
	fi
	echo "SSID pas DIRECT-RPi4 on sleep 1s"
	sleep 1
done

#boucle check IP contient 192.168.49
while :
do
	IP_ADDR=`wpa_cli -i wlan0 status | grep ip_address | sed 's/ip_address=//g'`
	echo "IP_ADDR=$IP_ADDR"
	if [ ! -z `echo $IP_ADDR | grep 192.168.49` ]; then
		break
	fi
	echo "L'IP=$IP_ADDR ne contient pas 192.168.49 on sleep 1s"
	sleep 1
done

echo "on tente ping sur 192.168.49.1"
ping -q -c 1 -W 1 192.168.49.1 2>&1 >/dev/null
PING_RESP=$?

echo "résultat du ping:$PING_RESP"

echo "fin du script"

