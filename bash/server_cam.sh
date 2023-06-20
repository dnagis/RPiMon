#!/bin/sh

#server_cam.sh
#servir rpicamsrc en tcpserversink
#lancé à partir d'un EXEC socat assigné dans le sysinit: 
#	socat -t 10 TCP-LISTEN:8000,fork EXEC:/bin/server_cam.sh &

#code maintenu dans RPiMon/bash/


#envoi pour tests depuis linux:
#echo paysage | socat - TCP:192.168.49.1:8000 

ARGS=$(cat) #Recuperation du message envoye par l emetteur


if [ "$ARGS" == "paysage" ]; then
	WIDTH=640
	HEIGHT=480
else
	HEIGHT=640
	WIDTH=480
fi

echo "script server_cam.sh args=$ARGS WIDTH=$WIDTH HEIGHT=$HEIGHT"

gst-launch-1.0 rpicamsrc do-timestamp=true ! video/x-h264,width=$WIDTH,height=$HEIGHT,framerate=30/1 ! h264parse ! queue ! rtph264pay config-interval=1 ! gdppay ! tcpserversink port=8888 host=0.0.0.0 & 



