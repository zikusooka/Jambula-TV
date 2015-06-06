#!/bin/bash
# Varaibles
VLC_CMD=/usr/bin/cvlc
V4L2_CTL_CMD=/usr/sbin/v4l2-ctl
V4L2_STANDARD=5 #255
LOGOFILE=/root/aextv.png
SAMPLE_RATE=22050  # 11025
WIDTH=320 #176
HEIGHT=240 #144
CHROMA=I420
#VCODEC=DIV3 # Try mp4v
VCODEC=MP4V # Try mp4v
ACODEC=mp3 # Try mp3 or mpga
#ACCESS=http
ACCESS=rtp
MUX=asf
MUX_CACHE=2048
#DST_ADDRESS=239.255.12.13
DST_ADDRESS=192.168.0.250

VB=1024 # 3000 or 512
AB=256 # 32 or 256
X=x
#VLC_OPTIONS="-vv --save-config" # Run Debugging mode and save config
VLC_OPTIONS="-v" # Run Debugging mode and save config
LOG_FILE=/var/log/vlc_tv_streaming.log
OSD_SCRIPT=/diskA/equator/scripts/AExBox/utilities/on-screen-display.py

HOST_IP_ADDRESS=`hostname -i`

WIRELESS_DEV=`iwconfig 2>&1 | grep "IEEE" | awk {'print $1'} | head -n 1`

DST_IP_WIRED=$HOST_IP_ADDRESS

DST_IP_WIRELESS_DEFAULT=172.16.0.1
# Check existence of WiFi device
if [ "x$WIRELESS_DEV" = "x" ];
then
# Give arbirary wiFi Address
DST_IP_WIRELESS=$DST_IP_WIRELESS_DEFAULT
else
DST_IP_WIRELESS=172.16.0.1
fi

DST_PORT_WIRED=8091
DST_PORT_WIRELESS=1736

export DISPLAY=:0.0
export XAUTHORITY="/root/.Xauthority"



#NUMBER=$1


# Source functions file
#. /diskA/equator/scripts/AExBox/functions


# Set Video/Aduio devices for streaming
TV_VIDEO_STREAMING_DEVICE=/dev/video1
TV_AUDIO_STREAMING_DEVICE=hw:1,0

VDEV=$TV_VIDEO_STREAMING_DEVICE
ADEV=$TV_AUDIO_STREAMING_DEVICE
#ADEV=alsa_output.pci-0000_00_14.0.analog-stereo


# Check to see if another process is using the video device
lsof $VDEV  | tail -n1 |grep $VDEV > /dev/null 2>&1
if [ `echo $?` = "0" ];
then
# Send OSD video device busy message 
$OSD_SCRIPT "Sorry, but the streaming device is already in use"
echo "Sorry, but the streaming device is already in use"
exit 1
fi

# Ask for TV Channel Number
#set_channel_kampala $NUMBER



FREQ=735500 #NTV
#FREQ=224500 # NBS
#FREQ=559500 # Citizen
#FREQ=503000 # WBS
STATION=NTV


#################
#  MAIN SCRIPT  #
#################

# Title of stream - ASF Only
if [ "$MUX" = "asf" ] || [ "$MUX" = "asfh" ];
then
STREAM_TITLE="title='AExTV',author=$STATION-Kampala-Uganda,copyright=2008-2009-AEx-Networks-All-rights-reserved,comment=Broadcasting-Live-from-the-AExBox,rating=PG14"
fi

# RTSP/RTP
#$VLC_CMD $VLC_OPTIONS v4l2://$VDEV --input-slave=alsa://$ADEV --alsa-samplerate=$SAMPLE_RATE --v4l2-standard=$V4L2_STANDARD --v4l2-chroma=$CHROMA --v4l2-input=0 --v4l2-audio-input=0 --v4l2-width=$WIDTH --v4l2-height=$HEIGHT --v4l2-tuner=0 --v4l2-tuner-frequency=$FREQ --v4l2-tuner-audio-mode=1 --logo-file $LOGOFILE --sout-mux-caching=$MUX_CACHE --sout '#transcode{vcodec='$VCODEC',acodec='$ACODEC',vb='$VB',ab='$AB',venc=ffmpeg{keyint=80,hurry-up,vt=800000},deinterlace}:rtp{dst=192.168.0.250,port=1234,sdp=rtsp://jambulatv:8090/test.sdp}'


#exit

# HTTP
# Stream to both Wired and Wirless Local Area Network
$VLC_CMD $VLC_OPTIONS v4l2://$VDEV --input-slave=alsa://$ADEV --alsa-samplerate=$SAMPLE_RATE --v4l2-standard=$V4L2_STANDARD --v4l2-chroma=$CHROMA --v4l2-input=0 --v4l2-audio-input=0 --v4l2-width=$WIDTH --v4l2-height=$HEIGHT --v4l2-tuner=0 --v4l2-tuner-frequency=$FREQ --v4l2-tuner-audio-mode=1 --logo-file $LOGOFILE --sout-mux-caching=$MUX_CACHE --sout '#duplicate{dst="transcode{vcodec='$VCODEC',sfilter=logo,acodec='$ACODEC',vb='$VB',ab='$AB',venc=ffmpeg{keyint=80,hurry-up,vt=800000},audio-sync,aenc=ffmpeg,samplerate=44100,deinterlace=blend}:duplicate{dst=standard{access=http,mux='$MUX'{'$STREAM_TITLE'},dst='$DST_IP_WIRED':'$DST_PORT_WIRED'},dst=standard{access=http,mux='$MUX'{'$STREAM_TITLE'},dst='$DST_IP_WIRELESS':'$DST_PORT_WIRELESS'}"}' 
