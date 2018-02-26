#!/bin/sh
# This script will run tests to ensure DVB-T tuner is setup correctly.
# Ensure DVBT devices nodes were created 
# Plus ensure that DVBT network in tvheadend exists and is setup properly
#
# Variables
REPAIR_COMMAND="/usr/bin/jambulatv-tvheadend-controller dvb repair"



#################
#  MAIN SCRIPT  #
#################
sudo $REPAIR_COMMAND
