#!/bin/sh

#Script qui controle le process de capture + detection

#commandes a envoyer: echo start | socat - TCP:192.168.49.1:8001 
#	start --> start en portrait (defaut)
#	start pa --> start en paysage
#	stop

#sysinit:
#socat -t 10 TCP-LISTEN:8001,fork EXEC:/bin/capt_detect_pilot.sh &
#envoi pour tests depuis linux:
#

STDIN=$(cat) #Recuperation du message envoye par l emetteur
read CMD ORIENTATION <<<$STDIN
echo script capt_detect_pilot.sh CMD=$CMD ORIENTATION=$ORIENTATION

if [ "$ORIENTATION" == "pa" ]; then
	WIDTH=640
	HEIGHT=480
else
	HEIGHT=640
	WIDTH=480
fi

PID_GST=`pidof gst-launch-1.0`


case "$CMD" in
 start)
    [[ ! -z $PID_GST ]] && kill $PID_GST
    logger start_rpimon
    gst-launch-1.0 -e --quiet rpicamsrc ! video/x-raw,width=$WIDTH,height=$HEIGHT,format=BGR,framerate=30/1 ! tee name=t t. ! queue ! v4l2h264enc ! 'video/x-h264,level=(string)3' ! h264parse ! mp4mux ! filesink location=capture.mp4 t. ! queue ! fdsink | ./stdin_to_detect po 0.5 &
    ;;
 stop)
    echo 'kill gst-launch-1.0 avec SIGINT' 
    kill -s SIGINT `pidof gst-launch-1.0`
    ;;
esac


