#!/usr/bin/sh

#focus_frame.sh --> côté client (focus)


#server_cam.sh paysage ou n'importe quel autre string pour portrait
ORIENTATION=$1

#vérif aufs gst
[[ ! -d /initrd/gst ]] && aufs gst

/initrd/mnt/dev_save/packages/RPiMon/bash/wifi_check.sh
echo start $ORIENTATION | socat - TCP:192.168.49.1:8000 #/bin/server_cam.sh
sleep 3 #un peu de slack pour que la pipeline ait le temps de démarrer
gst-launch-1.0 tcpclientsrc port=8888 host=192.168.49.1 ! gdpdepay ! rtph264depay ! vaapih264dec ! videoconvert ! vaapisink sync=false
echo fin du focus_frame
echo stop | socat - TCP:192.168.49.1:8000 #/bin/server_cam.sh
