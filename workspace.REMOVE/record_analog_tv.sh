#!/bin/sh
clear
TV_SHOW_DURATION=3600
vdevice=/dev/video1
adevice=/dev/dsp1

lnxdrv=v4l2


NUMBER=$1

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

set_channel_kampala 
MPLAYER_FREQ=$(awk "BEGIN{ print $FREQ/1000 }" )
#MPLAYER_FREQ=$FREQ
FILE=/tmp/$STATION.avi






##########
# RECORD #
##########

/usr/bin/mencoder tv:// -tv driver=$lnxdrv:input=0:norm=pal-bg:freq=$MPLAYER_FREQ:width=640:height=480:outfmt=yuy2:device=$vdevice:adevice=$adevice:audiorate=32000:forceaudio:forcechan=1:buffersize=64 -ovc lavc -lavcopts vcodec=mpeg4:vbitrate=1200:keyint=30 -oac copy br=128:cbr:mode=3 -ffourcc divx -endpos $TV_SHOW_DURATION -o $FILE


#> /dev/null 2>&1 &
