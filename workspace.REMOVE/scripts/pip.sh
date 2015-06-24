#!/bin/sh
# Display Picture-in-Picture(PIP) of your favorite TV channels at JambulaTV




# Variables
KODI_FAVOURITES=/JambulaTV/.kodi/userdata/favourites.xml
TVHEADEND_PLAYLIST=http://127.0.0.1:9981/playlist/channels

PIP_PLAYER_CMD="/usr/bin/cvlc"
PIP_PLAYER_OPTIONS="-I rc --no-audio --video-wallpaper --video-on-top --no-embedded-video --width 320 --height 240 --video-y 250 --video-x 700 --video-title-position 4 --video-title-timeout 20000"
#OTHER_OPTS="--daemon --pidfile /run/pip.pid"

# Works w/ Playlist
/usr/bin/cvlc -I oldrc --rc-unix sock --no-audio --video-wallpaper --video-on-top --no-embedded-video --width 320 --height 240 --video-y 250 --video-x 700 --video-title-position 4 --video-title-timeout 20000 playlist
#
echo -n  "next" | nc -U sock
#



grep -i pvr $KODI_FAVOURITES | grep favourite | while read FAVORITE
do


# Set channel variables
CHANNEL_NAME="$(echo $FAVORITE | cut -d '"' -f2)"
CHANNEL_URL="$(curl -sS $TVHEADEND_PLAYLIST | grep -A1 "$CHANNEL_NAME" | tail -1 | sed -e 's:&profile=pass::g')"



PIP_STATE_FILE=/var/tmp/pip_state

# Ensure status file exists, and its size is greater than 0 
[ -s "$PIP_STATE_FILE" ] || echo -n "OFF" > $PIP_STATE_FILE
# Set current state variable                                                
PIP_STATE=`cat $PIP_STATE_FILE`

case $PIP_STATE in
# Turn on if off
OFF)
# Create status file
echo -n "ON" > $PIP_STATE_FILE

# Turn On PIP
# --------------

#$PIP_PLAYER_CMD $PIP_PLAYER_OPTIONS --video-title $CHANNEL_NAME --meta-title "$CHANNEL_NAME" "$CHANNEL_URL" > /dev/null 2>&1

$PIP_PLAYER_CMD $PIP_PLAYER_OPTIONS $OTHER_OPTS --video-title $CHANNEL_NAME --meta-title "$CHANNEL_NAME" "$CHANNEL_URL" 

#> /dev/null 2>&1
exit
;;

# Turn PIP Off if on
# ------------------
ON)
# Create status file
echo -n "OFF" > $PIP_STATE_FILE

# Kill VLC process
VLC_PID=$(ps auxw | grep vlc | grep video-wallpaper | awk {'print $2'})
kill $VLC_PID
;;
esac



done



