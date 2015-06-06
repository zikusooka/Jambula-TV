#!/bin/sh
clear
MPLAYER_CMD=/usr/bin/mplayer
MPLAYER_OPTIONS="-ao pulse -novideo -nolirc -cache 10000 -cache-min 20"
V4L2_RADIO_CMD=/usr/bin/fm
V4L2_RADIO_DEV=/dev/radio1
V4L2_AUDIO_CAPTURE_DEV="hw=1.0"
V4L2_AUDIO_RATE=32000




# Quit if station is not inputed i.e Usage
if [ "x$1" = "x" ]
then
echo "Usage:  ./`basename $0` 94.8
"
exit 1
fi



killall mplayer || killall -9 mplayer

# Play Radio using MPlayer
$MPLAYER_CMD $MPLAYER_OPTIONS radio://$1/capture -radio device=$V4L2_RADIO_DEV:adevice=$V4L2_AUDIO_CAPTURE_DEV -rawaudio rate=$V4L2_AUDIO_RATE

# Play Radio using fm tool
#$V4L2_RADIO_CMD -d $V4L2_RADIO_DEV -q -T forever $1 65535 & 
#$PLAY_CMD $V4L2_AUDIO_CAPTURE_DEV &
#paplay -d "alsa_output.pci-0000_00_1b.0.analog-stereo"
