#!/usr/bin/sh

#focus_frame.sh --> côté client


#server_cam.sh paysage ou n'importe quel autre string pour portrait
ORIENTATION=$1


/initrd/mnt/dev_save/packages/RPiMon/bash/wifi_check.sh
echo $ORIENTATION | socat - TCP:192.168.49.1:8000 #server_cam.sh
sleep 3 #un peu de slack pour que la pipeline ait le temps de démarrer
gst-launch-1.0 tcpclientsrc port=8888 host=192.168.49.1 ! gdpdepay ! rtph264depay ! vaapih264dec ! videoconvert ! vaapisink sync=false
