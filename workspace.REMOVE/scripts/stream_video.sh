#!/bin/sh
clear
# Varaibles
VLC_CMD=/usr/bin/vlc
SCRIPT_FILE=/tmp/vlc.sh
VIDEO_INPUT_DIR=$@
BASE_DIRECTORY=`echo $VIDEO_INPUT_DIR |sed -e "s/ /\*/g"`
VIDEO_DIRECTORY=$BASE_DIRECTORY
LOGOFILE=/usr/share/freevo/images/panorama/logo.png
DEBUG=vvv
VDEV=/dev/video1
ADEV=/dev/dsp1
#FREQ=551250
WIDTH=640 #176
HEIGHT=480 #144
VCODEC=mp4v # Try mp4v or DIV3 
ACODEC=mpga # Try mpga or mp3
ACCESS=VIDEO_FILE
MUX=asf # Try ogg or asf
DST_FILE=output.mp4

X=x

VLC_OPTIONS="-I dummy --daemon --loop"


LOG_FILE=/var/log/vlc_video_streaming.log
OSD_SCRIPT=/diskA/equator/scripts/AExBox/utilities/on-screen-display.py

NETWORK_ETHERNET_DEVICE=$(ip link | grep '2: ' | cut -d : -f2 | head -1 | sed -e 's/ //g')
NETWORK_IP_ADDRESS=$(ip -4 addr show dev $NETWORK_ETHERNET_DEVICE | grep brd | awk {'print $2'} | cut -d / -f1)

WIRELESS_DEV=`iwconfig 2>&1 | grep "IEEE" | awk {'print $1'} | head -n 1`

DST_IP_WIRED=$HOST_IP_ADDRESS

DST_IP_WIRELESS_DEFAULT=172.16.0.1
# Check existence of WiFi device
if [ "x$WIRELESS_DEV" = "x" ];
then
# Give arbirary wiFi Address
DST_IP_WIRELESS=$DST_IP_WIRELESS_DEFAULT
else
DST_IP_WIRELESS=`ifconfig | grep P-t-P | awk {'print $2'} | cut -d ":" -f2 | tail -n 1`
fi

DST_PORT_WIRED=8093
DST_PORT_WIRELESS=1738

DST_IP_WIRELESS=172.16.0.1




# Stream Video to Wired and Wireless Local Area Network
# -----------------------------------------------------
$VLC_CMD $VLC_OPTIONS $VIDEO_DIRECTORY --sout '#duplicate{dst=standard{access=http,mux='$MUX',dst='$DST_IP_WIRED':'$DST_PORT_WIRED'},dst=standard{access=http,mux='$MUX',dst='$DST_IP_WIRELESS':'$DST_PORT_WIRELESS'}"}' > $LOG_FILE 2>&1 &
