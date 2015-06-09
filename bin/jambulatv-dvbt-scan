#!/bin/sh
#
#This script will scan for Free-to-Air Digital TV broadcasts in Uganda
#
# NOTE: For this script you need to first install w_scan utility 
# i.e. In Fedora/Red Hat:  yum -vy install w_scan

# Copyright (C) 2011 Joseph Zikusooka.
#
# Contact me at: joseph AT zikusooka.com


HOME_DIR=$HOME
W_SCAN_CMD=`which w_scan`
DVB_TYPE=t #(DVB-T)

APP_NUMBER=$1
COUNTRY_CODE=$2

# If empty set to default
if [ "x$APP_NUMBER" = "x" ];
then
clear
echo "Usage: ./`basename $0` [Program_used_to_play_TV e.g. 1] [COUNTRY]

1. Xine

2. VLC

3. Initial Tuning Data

4. Mplayer

5. Kaffeine

6. Gstreamer
"
exit 1
fi


if [ "x$COUNTRY_CODE" = "x" ];
then
COUNTRY_CODE=UG
fi



case $APP_NUMBER in
1|'')
# Xine
CHANNELS_FILE_FORMAT=X
APP_CONFIG_DIR=$HOME_DIR/.xine
CHANNELS_FILE=$APP_CONFIG_DIR/channels.conf
;;
2)
# VLC
CHANNELS_FILE_FORMAT=L
APP_CONFIG_DIR=.config/vlc
CHANNELS_FILE=$APP_CONFIG_DIR/channels.xspf
;;
3)
# Initial Tuning Data
CHANNELS_FILE_FORMAT=x
APP_CONFIG_DIR=/usr/share/dvb/dvb-$DVB_TYPE
CHANNELS_FILE=$APP_CONFIG_DIR/auto-$COUNTRY_CODE
;;
4)
# Mplayer
CHANNELS_FILE_FORMAT=M
APP_CONFIG_DIR=$HOME_DIR/.mplayer
CHANNELS_FILE=$APP_CONFIG_DIR/channels.conf
;;
5)
# Kaffeine
CHANNELS_FILE_FORMAT=k
APP_CONFIG_DIR=$HOME_DIR/.kaffeine
CHANNELS_FILE=$APP_CONFIG_DIR/channels.conf
;;
6)
# GStreamer
CHANNELS_FILE_FORMAT=G
APP_CONFIG_DIR=$HOME_DIR/.gstreamer*
CHANNELS_FILE=$APP_CONFIG_DIR/channels.dvbsrc
;;
*)
# Others
CHANNELS_FILE_FORMAT="o 6"
APP_CONFIG_DIR=$HOME_DIR
CHANNELS_FILE=$APP_CONFIG_DIR/channels.conf
;;
esac





#################
#  MAIN SCRIPT  #
#################
# Check who is running this script
if [ "`whoami`" != "root" ];
then
clear
echo "ERROR: Incorrect user: You need to run this script as root!
"
exit 1
fi


# Create App config directory if it does not exist
[ -d $APP_CONFIG_DIR ] || mkdir -p $APP_CONFIG_DIR
# Backup existing file
[ ! -e $CHANNELS_FILE ] || mv -v $CHANNELS_FILE $CHANNELS_FILE.`date +%Y%m%d`

# Scan
#w_scan -f $DVB_TYPE -c $COUNTRY_CODE -$CHANNELS_FILE_FORMAT -E 0 > $CHANNELS_FILE
w_scan -f $DVB_TYPE -c $COUNTRY_CODE -$CHANNELS_FILE_FORMAT -E 1 > $CHANNELS_FILE

# Location of channels.conf file
clear
echo "Your channels.conf file is located at:
$CHANNELS_FILE
"
