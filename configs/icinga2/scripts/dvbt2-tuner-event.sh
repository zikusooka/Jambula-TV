#!/bin/sh
#
# This script checks the status of the DVB-T tuner and where it is failing, Repair and Fix it
# This was necessiated by very buggy August DVBT tuner frequently fails

# Variables



#################
#  MAIN SCRIPT  #
#################

#Play sound effects of dying hardware
mplayer -ao pulse -novideo  /usr/share/JambulaTV/sounds/on_life_support.mp3

# Stop tvheadend server
sudo systemctl stop tvheadend.service

# Fix issue - Reset DVB module that is acting up 
#modprobe -r dvb_usb_cxusb

# Restart tvheadend
sudo systemctl start tvheadend.service
