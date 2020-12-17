#!/bin/sh
#
# This script checks the status of the DVB-T tuner and where it is failing, Repair and Fix it
# This was necessiated by very buggy August DVBT tuner frequently fails

# Variables
SERVICE_DESCRIPTION=$SERVICEDESC
SERVICE_STATE=$SERVICESTATE
SERVICE_DATE=$LONGDATETIME
SERVICE_DISPLAY_NAME=$SERVICEDISPLAYNAME



#################
#  MAIN SCRIPT  #
#################
# Quit if service is OK
[[ "$SERVICE_STATE" = "OK" ]] && exit 0

#Play sound effects of dying hardware
mplayer -ao pulse -novideo  /usr/share/JambulaTV/sounds/on_life_support.mp3

# Stop tvheadend server
sudo systemctl stop tvheadend.service

# Fix issue - Reset DVB module that is acting up 
#/usr/sbin/modprobe -r dvb_usb_dvbsky
#/usr/sbin/modprobe dvb_usb_dvbsky

# Restart tvheadend
sudo systemctl start tvheadend.service
