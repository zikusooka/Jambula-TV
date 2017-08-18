#!/bin/sh
# This is a AGI script for JambulaTV Recordings
# Jambula Labs @copyright 2017-2018 All rights reserved

# Variables
ALL_TV_CHANNELS_LIST_FILE=$(grep ^ALL_TV_CHANNELS_LIST `which jambulatv-kodi-controller` | cut -d '=' -f2 | head -1 | awk {'print $1'})
TV_CHANNEL_SELECTED=$2
TV_CHANNEL_2_SEARCH=$2
ASTERISK_AGI_BIN_DIR=/var/lib/asterisk/agi-bin
TV_CHANNELS_TTS_FILE=/tmp/tv_channels_tts_file



###############
#  FUNCTIONS  #
###############
usage () {
clear
cat <<EOF
Usage: $(basename $0) [get|read|search] [TV Channel Number]
EOF
exit 1
}

generate_list_of_tv_channels () {
# Generate current list of all TV channels
jambulatv-kodi-controller tv_channels
}

get_name_of_requested_tv_channel () {
# Print out name of TV channel
TV_CHANNEL_NAME=$(grep "^$TV_CHANNEL_SELECTED|" $ALL_TV_CHANNELS_LIST_FILE | cut -d '|' -f2-)
echo $TV_CHANNEL_NAME
}

read_list_of_tv_channels () {
# Remove previous tv channels tts file 
[ -e $TV_CHANNELS_TTS_FILE ] && rm -f $TV_CHANNELS_TTS_FILE

# Read channels and their numbers to user
cat $ALL_TV_CHANNELS_LIST_FILE | while read LINE
do
TV_CHANNEL_NAME=$(echo $LINE | cut -d '|' -f2-)
TV_CHANNEL_NUMBER=$(echo $LINE | cut -d '|' -f1)
# Add TV Channel name and number to temp file
echo -n "$TV_CHANNEL_NAME is $TV_CHANNEL_NUMBER  " >> $TV_CHANNELS_TTS_FILE
done
}



################
#  MAIN SCRIPT #
################

generate_list_of_tv_channels > /dev/null 2>&1

case $1 in
get)
[ "x$TV_CHANNEL_SELECTED" = "x" ] && usage
get_name_of_requested_tv_channel $TV_CHANNEL_SELECTED
;;

read)
read_list_of_tv_channels
;;

search)
[ "x$TV_CHANNEL_2_SEARCH" = "x" ] && usage
search_list_of_tv_channels $TV_CHANNEL_2_SEARCH
;;

*)
usage
;;
esac
