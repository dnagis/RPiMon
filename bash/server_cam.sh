#!/bin/sh

#server_cam.sh
#servir rpicamsrc en tcpserversink
#lancé à partir d'un EXEC socat assigné dans le sysinit: 
#	socat -t 10 TCP-LISTEN:8000,fork EXEC:/bin/server_cam.sh &

#code maintenu dans RPiMon/bash/


#envoi pour tests depuis linux:
#echo pa | socat - TCP:192.168.49.1:8000 

ARGS=$(cat) #Recuperation du message envoye par l emetteur

if [ "$ARGS" == "pa" ]; then
	WIDTH=640
	HEIGHT=480
else
	HEIGHT=640
	WIDTH=480
fi

echo "script /bin/server_cam.sh (repo RPiMon) args=$ARGS WIDTH=$WIDTH HEIGHT=$HEIGHT"


PID_GST=`pidof gst-launch-1.0`
if [ ! -z $PID_GST ]; then
	echo "pid gst-launch-1.0: $PID_GST on le kill"
	kill $PID_GST
fi


gst-launch-1.0 rpicamsrc do-timestamp=true ! video/x-h264,width=$WIDTH,height=$HEIGHT,framerate=30/1 ! h264parse ! queue ! rtph264pay config-interval=1 ! gdppay ! tcpserversink port=8888 host=0.0.0.0 & 



