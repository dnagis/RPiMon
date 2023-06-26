#!/bin/sh

#Script qui fetche infos sur le process de capture + detection

#appel depuis focus: echo zob | socat - TCP:192.168.49.1:8002

#sysinit:
#socat -t 10 TCP-LISTEN:8002,fork EXEC:/bin/scope_rpi.sh &


#STDIN=$(cat) #Recuperation du message envoye par l emetteur
#echo script scope_rpi.sh STDIN=$STDIN


PID_GST=`pidof gst-launch-1.0`
#awk '{$1=$1};1' delete leading + trailing spaces
CAPT_SIZE=`ls -s /root/capture.mp4 | awk '{$1=$1};1' | cut -d' ' -f1 -s`


echo PID_GST=$PID_GST
echo CAPT_SIZE=$CAPT_SIZE
tail /root/results.txt




