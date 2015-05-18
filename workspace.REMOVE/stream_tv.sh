#!/bin/bash
# Varaibles
# Channel Number
NUMBER=$1
VDEV=/dev/video1
#ADEV=/dev/dsp1
ADEV="hw:1,0"
VLC_CMD=/usr/bin/cvlc
V4L2_CTL_CMD=/usr/sbin/v4l2-ctl
V4L2_STANDARD=5 #255
LOGOFILE=aextv.png
SAMPLE_RATE=22050  # 11025
WIDTH=320 #176
HEIGHT=240 #144
WIDTH_LOCAL=1024 #176
HEIGHT_LOCAL=768 #144
CHROMA=I420
#VCODEC=DIV3 # Try mp4v
VCODEC=mp4v # Try mp4v
ACODEC=mp3 # Try mp3 or mpga
ACCESS=http
MUX=asf # Try asf or ogg
MUX_CACHE=2048
VB=1024 # 3000 or 512
AB=256 # 32 or 256
X=x
VLC_OPTIONS="-vvv" # Run Debugging mode and save config
LOG_FILE=/var/log/vlc_tv_streaming.log
OSD_SCRIPT=/diskA/equator/scripts/AExBox/utilities/on-screen-display.py

HOST_IP_ADDRESS=`hostname -i`

WIRELESS_DEV=`ip link | grep '2: ' | cut -d : -f2 | head -1 | sed -e 's/ //g'`

DST_IP_WIRED=$HOST_IP_ADDRESS

DST_IP_WIRELESS_DEFAULT=172.16.0.1
# Check existence of WiFi device
if [ "x$WIRELESS_DEV" = "x" ];
then
# Give arbirary wiFi Address
DST_IP_WIRELESS=$DST_IP_WIRELESS_DEFAULT
else
DST_IP_WIRELESS=$(ip addr show dev tun0 | grep -i inet | awk {'print $2'} | cut -d "/" -f1)
fi


DST_PORT_WIRED=8091
DST_PORT_WIRELESS=1736

export DISPLAY=:0.0
export XAUTHORITY="/root/.Xauthority"



###############
#  FUNCTIONS  #
###############

video_device_status () {
# Check to see if another process is using the video device
lsof $VDEV  | tail -n1 |grep $VDEV > /dev/null 2>&1
if [ `echo $?` = "0" ];
then
# Send OSD video device busy message 
echo "Sorry, but the streaming device is already in use"
exit 1
fi
}

# Ask for TV Channel and Set the number, frequency, label, etc
# -------------------------------------------------------------
set_channel_kampala () {

clear
# Check if Channel was specified at command line
if [ "x$NUMBER" = "x" ];
then
# Ask for TV Channels to Watch - Kampala
echo "Please select the TV channel number:

UBC 	-> 	 5
STAR 	->	 7
NBS 	-> 	12
BUKEDDE -> 	13
LTV 	-> 	22
WBS 	-> 	25
TOP 	-> 	28
EATV 	-> 	31
CITIZEN	-> 	32
ITV 	-> 	34
STAR 	-> 	40
RECORD 	-> 	42
SPORTS 	-> 	43
CHAN44 	-> 	44
NTV 	-> 	54	

NOTE: If Streaming FM Radio, just enter the Radio Station Frequency
"
read NUMBER
fi
# Set TV Channel number and Frequency TV Channels based on above selection
case $NUMBER in
5)
CHAN=5
FREQ=175500
STATION=UBC
;;
7)
CHAN=7
FREQ=189500
STATION=STAR
;;
10)
CHAN=10
FREQ=210000
STATION=CAPITAL?
;;
12)
CHAN=12
FREQ=224500
STATION=NBS
;;
13)
CHAN=13
FREQ=231500
STATION=BUKEDDE
;;
22)
CHAN=22
FREQ=479250
STATION=LTV
;;
25)
CHAN=25
FREQ=503250
STATION=WBS
;;
28)
CHAN=28
FREQ=527250
STATION=TOPTV
;;
31)
CHAN=31
FREQ=551250
STATION=EATV
;;
32)
CHAN=32
FREQ=559250
STATION=CITIZEN
;;
34)
CHAN=34
FREQ=575250
STATION=ITV
;;
40)
CHAN=40
FREQ=623250
STATION=STAR
;;
42)
CHAN=42
FREQ=639250
STATION=RECORDTV
;;
43)
CHAN=43
FREQ=647250
STATION=SPORTSTV
;;
44)
CHAN=44
FREQ=655250
STATION=CHANNEL44
;;
54)
CHAN=54
#FREQ=735250
FREQ=735250
STATION=NTV
;;
56)
CHAN=54
FREQ=751250
STATION=STAR-TV
;;
*.*)
echo "Radio Streaming"
;;
*)
echo "Error: You entered an incorrect TV channel, please try again"
exit 1
;;
esac

# Export TV Channel variables
export NUMBER CHAN FREQ STATION
}


set_mixer () {
sudo /usr/bin/amixer -q -c 0 sset PCM 60% unmute 
sudo /usr/bin/amixer -q -c 0 sset Master 60% unmute
}



#################
#  MAIN SCRIPT  #
#################
# Check if video device is in use
video_device_status

# Ask for TV Channel Number
set_channel_kampala $NUMBER

# Title of stream - ASF Only
if [ "$MUX" = "asf" ] || [ "$MUX" = "asfh" ];
then
STREAM_TITLE="title='AExTV',author=$STATION-Kampala-Uganda,copyright=2008-2009-AEx-Networks-All-rights-reserved,comment=Broadcasting-Live-from-the-AExBox,rating=PG14"
fi

#
#$VLC_CMD $VLC_OPTIONS v4l2://$VDEV --input-slave=alsa://$ADEV --alsa-samplerate=$SAMPLE_RATE --v4l2-standard=$V4L2_STANDARD --v4l2-chroma=$CHROMA --v4l2-input=0 --v4l2-audio-input=0 --v4l2-width=$WIDTH --v4l2-height=$HEIGHT --v4l2-tuner-frequency=$FREQ --v4l2-tuner-audio-mode=1 --logo-file $LOGOFILE --sout-mux-caching=$MUX_CACHE --height $HEIGHT_LOCAL --width $WIDTH_LOCAL --sout '#duplicate{dst="transcode{vcodec='$VCODEC',sfilter=logo,acodec='$ACODEC',vb='$VB',ab='$AB',venc=ffmpeg{keyint=80,hurry-up,vt=800000},audio-sync,aenc=ffmpeg,samplerate=44100,deinterlace=blend}:duplicate{dst=display,dst=standard{access=http,mux='$MUX'{'$STREAM_TITLE'},dst='$DST_IP_WIRED':'$DST_PORT_WIRED'},dst=standard{access=http,mux='$MUX'{'$STREAM_TITLE'},dst='$DST_IP_WIRELESS':'$DST_PORT_WIRELESS'}"}' > $LOG_FILE 2>&1 &
$VLC_CMD $VLC_OPTIONS v4l2://$VDEV --input-slave=alsa://$ADEV --alsa-samplerate=$SAMPLE_RATE --v4l2-standard=$V4L2_STANDARD --v4l2-chroma=$CHROMA --v4l2-input=0 --v4l2-audio-input=0 --v4l2-width=$WIDTH --v4l2-height=$HEIGHT --v4l2-tuner-frequency=$FREQ --v4l2-tuner-audio-mode=1 --logo-file $LOGOFILE --sout-mux-caching=$MUX_CACHE --height $HEIGHT_LOCAL --width $WIDTH_LOCAL --sout '#duplicate{dst="transcode{vcodec='$VCODEC',sfilter=logo,acodec='$ACODEC',vb='$VB',ab='$AB',venc=ffmpeg{keyint=80,hurry-up,vt=800000},audio-sync,aenc=ffmpeg,samplerate=44100,deinterlace=blend}:duplicate{dst=standard{access=http,mux='$MUX'{'$STREAM_TITLE'},dst='$DST_IP_WIRED':'$DST_PORT_WIRED'},dst=standard{access=http,mux='$MUX'{'$STREAM_TITLE'},dst='$DST_IP_WIRELESS':'$DST_PORT_WIRELESS'}"}' 
