#!/usr/bin/sh

#watch_scope.sh --> côté client (focus)

clear

while :
do

#curseur en haut à gauche
tput cup 0 0

RESP=$(echo zob | socat - TCP:192.168.49.1:8002)

#echo "$RESP" #Attention echo $RESP enlève les newlines

PID_GST=`echo "$RESP" | grep ^PID_GST | sed 's/PID_GST=//g'`
CAPT_SIZE=`echo "$RESP" | grep ^CAPT_SIZE | sed 's/CAPT_SIZE=//g'`

echo PID_GST=$PID_GST

#echo -e "\\033[1;32mfin du script SSID=$SSID IP_ADDR=$IP_ADDR et ping OK\\033[0;39m"

[[ $((CAPT_SIZE)) -gt $((CAPT_SIZE_OLD)) ]] && echo -ne "\\033[1;32m"

echo CAPT_SIZE=$CAPT_SIZE

echo -ne "\\033[0;39m"



#enlever les deux premières lignes
echo "$RESP" | sed '1d;2d'

CAPT_SIZE_OLD=$CAPT_SIZE

sleep 2
done
