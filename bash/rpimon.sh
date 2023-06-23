#!/bin/sh

#Script originel utilisé au tout début 2022

#sysinit:
#socat -t 10 TCP-LISTEN:4696,fork EXEC:/root/rpimon.sh &
#envoi pour tests depuis linux:
#echo start | socat - TCP:192.168.49.1:4696 

STDIN=$(cat) #Recuperation du message envoye par l emetteur

case "$STDIN" in
 tcp)
    echo 'tcpserver depuis rpicam'
    gst-launch-1.0 rpicamsrc do-timestamp=true ! video/x-h264,width=480,height=640,framerate=30/1 ! h264parse ! queue ! rtph264pay config-interval=1 ! gdppay ! tcpserversink port=8888 host=0.0.0.0 & 
    ;;
 pidof)
    echo 'output de pidof gst-launch-1.0:'
    pidof gst-launch-1.0
    ;;
 kill)
    echo 'kill gst-launch-1.0 avec SIGINT' 
    kill -s SIGINT `pidof gst-launch-1.0`
    ;;
 start)
    logger start_rpimon
    kill `pidof test-launch`
    /root/gst_respawn.sh &
    ;;
 stop)
    logger stop_rpimon   
    kill -s SIGINT `pidof gst_respawn.sh`
    poweroff
    ;;  
 *)
    echo $STDIN >> /root/LOG_rpimon
esac


