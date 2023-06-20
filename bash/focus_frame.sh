#!/usr/bin/sh

#focus_frame.sh --> côté client


/initrd/mnt/dev_save/packages/RPiMon/bash/wifi_check.sh
echo portrait | socat - TCP:192.168.49.1:8000
gst-launch-1.0 tcpclientsrc port=8888 host=192.168.49.1 ! gdpdepay ! rtph264depay ! vaapih264dec ! videoconvert ! vaapisink sync=false
