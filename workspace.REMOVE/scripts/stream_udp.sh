#!/bin/bash
# Varaibles
VLC_CMD=/usr/bin/cvlc
V4L2_STANDARD=5 #255
LOGOFILE=/root/aextv.png
SAMPLE_RATE=22050  # 11025
WIDTH=320 #176
HEIGHT=240 #144
CHROMA=I420
VCODEC=mp4v # Try DIV3
ACODEC=mp3 # Try mpga
ACCESS_RTP=rtp
ACCESS_HTTP=http
MUX_ASF=asf
MUX_TS=ts
MUX_CACHE=2048
VB=1024 # 3000 or 512
AB=256 # 32 or 256
VLC_OPTIONS="-v --x11-display=:0.0" 
LOG_FILE=/var/log/JambulaTV/vlc_tv_streaming.log
OSD_SCRIPT=/usr/bin/jambulatv-on-screen-display

# Determine Wired and Wireless IP Addresses
HOST_IP_ADDRESS=`hostname -i`
WIRELESS_DEV=`iwconfig 2>&1 | grep "IEEE" | awk {'print $1'} | head -n 1`
# HTTP IP Address (Wired)
DST_HTTP_ADDRESS_WIRED=$HOST_IP_ADDRESS

# HTTP IP Address (Wireless)
DST_HTTP_ADDRESS_WIRELESS_DEFAULT=172.16.0.1
# Check existence of WiFi device
if [ "x$WIRELESS_DEV" = "x" ];
then
# Give abitrary wiFi Address
DST_HTTP_ADDRESS_WIRELESS=$DST_HTTP_ADDRESS_WIRELESS_DEFAULT
else
DST_HTTP_ADDRESS_WIRELESS=`ifconfig $WIRELESS_DEV | grep inet | awk {'print $2'} | cut -d ":" -f2 | tail -n 1`
fi
# If WiFi dev is not given IP address - set one to default
if [ "x$DST_HTTP_ADDRESS_WIRELESS" = "x" ];
then
ifconfig $WIRELESS_DEV $DST_HTTP_ADDRESS_WIRELESS_DEFAULT
DST_HTTP_ADDRESS_WIRELESS=$DST_HTTP_ADDRESS_WIRELESS_DEFAULT
fi

# HTTP Ports
DST_HTTP_PORT_WIRED=8091
DST_HTTP_PORT_WIRELESS=1736

# RTP IP Address
DST_RTP_ADDRESS=239.255.1.2


# Other variables
export DISPLAY=:0.0
export XAUTHORITY="/root/.Xauthority"

# Set Video/Audio devices for streaming
TV_VIDEO_STREAMING_DEVICE=/dev/video1
#TV_AUDIO_STREAMING_DEVICE=hw:1,0

# TV Frequencies
TV_FREQUENCY=735500
#TV_FREQUENCY=503000
TV_STATION_NAME=NTV

STREAM_INFO_ASF="title='JambulaTV',author=$TV_STATION_NAME-Kampala-Uganda,copyright=2013-2014-Jambula-Labs-All-rights-reserved,comment=Broadcasting-Live-from-the-JambulaTV,rating=PG14"



# TO DO
# Make input_Stream variables - functions?




###############
# MAIN SCRIPT #
###############

# Check to see if another process is using the video device
lsof $TV_VIDEO_STREAMING_DEVICE  | tail -n1 |grep $TV_VIDEO_STREAMING_DEVICE > /dev/null 2>&1
if [ `echo $?` = "0" ];
then
# Send OSD video device busy message 
$OSD_SCRIPT "Sorry, but the streaming device is already in use"
echo "Sorry, but the streaming device is already in use"
exit 1
fi



$VLC_CMD $VLC_OPTIONS v4l2://$TV_VIDEO_STREAMING_DEVICE --input-slave=alsa://$TV_AUDIO_STREAMING_DEVICE --alsa-samplerate=$SAMPLE_RATE --v4l2-standard=$V4L2_STANDARD --v4l2-chroma=$CHROMA --v4l2-input=0 --v4l2-audio-input=0 --v4l2-width=$WIDTH --v4l2-height=$HEIGHT --v4l2-tuner=0 --v4l2-tuner-frequency=$TV_FREQUENCY --v4l2-tuner-audio-mode=1 --logo-file $LOGOFILE --sout-mux-caching=$MUX_CACHE --sout '#duplicate{dst="transcode{vcodec='$VCODEC',sfilter=logo,acodec='$ACODEC',vb='$VB',ab='$AB',venc=ffmpeg{keyint=80,hurry-up,vt=800000},audio-sync,aenc=ffmpeg,samplerate=44100,deinterlace=blend}:duplicate{dst='$ACCESS_RTP'{mux='$MUX_TS',dst='$DST_RTP_ADDRESS',port=5004,sdp=sap,name='$TV_STATION_NAME'},dst='$ACCESS_HTTP'{mux='$MUX_ASF'{'$STREAM_INFO_ASF'},dst='$DST_HTTP_ADDRESS_WIRED':'$DST_HTTP_PORT_WIRED'},dst='$ACCESS_HTTP'{mux='$MUX_ASF'{'$STREAM_INFO_ASF'},dst='$DST_HTTP_ADDRESS_WIRELESS':'$DST_HTTP_PORT_WIRELESS'}"}'

