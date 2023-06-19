#!/usr/bin/bash

#Côté client: check des étapes de connexion wifi à partir de wpa_cli -i wlan0 status puis ping



#collect info from wpa_cli -i wlan0 status
#WPA_STATE=`wpa_cli -i wlan0 status | grep wpa_state | sed 's/wpa_state=//g'`
#SSID=`wpa_cli -i wlan0 status | grep ^ssid | sed 's/ssid=//g'`
#IP_ADDR=`wpa_cli -i wlan0 status | grep ip_address | sed 's/ip_address=//g'`


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

#boucle check ping
while :
do
ping -q -c 1 -W 1 192.168.49.1 2>&1 >/dev/null && break
echo "ping 192.168.49.1 n'a pas retourné 0 on sleep 1s"
sleep 1
done



echo -e "\\033[1;32mfin du script SSID=$SSID IP_ADDR=$IP_ADDR et ping OK\\033[0;39m"

