#!/bin/sh
# This script will run tests to ensure DVB-T tuner is setup correctly.
# Ensure DVBT devices nodes were created 
# Plus ensure that DVBT network in tvheadend exists and is setup properly
#
# Variables
SERVICE_DESCRIPTION=$SERVICEDESC
SERVICE_STATE=$SERVICESTATE
SERVICE_DATE=$LONGDATETIME
SERVICE_DISPLAY_NAME=$SERVICEDISPLAYNAME

SERVICE_REPAIR_COMMAND="/usr/bin/jambulatv-tvheadend-controller dvb repair"



#################
#  MAIN SCRIPT  #
#################

# Repair DVB-T2 network
[[ "$SERVICE_STATE" = "OK" ]] || sudo $SERVICE_REPAIR_COMMAND
