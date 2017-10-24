#!/bin/sh
# This script will run tests to ensure DVB-T tuner is setup correctly.
# Ensure DVBT devices nodes were created 
# Plus ensure that DVBT network in tvheadend exists and is setup properly
#
# Variables
PROJECT_NAME=JambulaTV
PROJECT_SYSTEM_CONF_DIR=/etc/$PROJECT_NAME
PROJECT_FUNCTIONS_FILE=$PROJECT_SYSTEM_CONF_DIR/functions
PROJECT_DVBT_SETTINGS_FILE=$PROJECT_SYSTEM_CONF_DIR/dvbt-settings.cfg

# Source install functions
. $PROJECT_FUNCTIONS_FILE

# Source DVBT settings file
. $PROJECT_DVBT_SETTINGS_FILE

# Other variables
PVR_STATUS_FILE=/tmp/pvr_status # Use the same file in '/usr/bin/jambulatv-kodi-controller'
PVR_STATUS_CMD="/usr/bin/jambulatv-kodi-controller addon_status pvr.hts"
#
# DVB-T Tuner node
TVHEADEND_DVBT_TUNER_NODE=/dev/dvb/adapter$DVBT_TUNER_NO
# See if DVBT network UUID exists
TVHEADEND_DVBT_NETWORK_UUID=$(curl -s http://127.0.0.1:9981/api/mpegts/network/grid?limit=100000 | jq '.entries[] | select(.networkname=="'"$DVBT_NETWORK_NAME"'") |.uuid' | sed 's:"::g')
# Check for non-set-channels
curl -s http://127.0.0.1:9981/api/channel/list?limit=10000 | jq '.entries[]' | grep 'name-not-set' > /dev/null 2>&1
NONE_SET_CHANNELS_FOUND=$?
# Notices
OSD_NOTICE_NO_TUNER="Error:  Unable to detect the TV Tuner. This is most likely a hardware issue.  Please check your DVB-T2 tuner and ensure it is properly connected"
OSD_NOTICE_NO_NETWORK="Error:  The TV Channels list is corrupted. This may be due to a bad shutdown previously. I will attempt to correct it now, please try again shortly"



#################
#  MAIN SCRIPT  #
#################

#  PVR Status Query
$PVR_STATUS_CMD > /dev/null 2>&1
# Pull Status
. $PVR_STATUS_FILE
#
# Quit if Kodi PVR Manager is not enabled
[ "$ADDON_STATUS" = "true" ] || exit 0

# If no DVB-T2 tuner was found
if [[ ! -e "$TVHEADEND_DVBT_TUNER_NODE" ]];
then
# OSD notice
sudo /usr/bin/jambulatv-osd -m "$OSD_NOTICE_NO_TUNER"
# CLI notice
clear && echo "$OSD_NOTICE_NO_TUNER"
# If DVBT Network was accidentally wiped out
elif [[ "$NONE_SET_CHANNELS_FOUND" = "0" && "x$TVHEADEND_DVBT_NETWORK_UUID" = "x" ]];
then
# OSD notice
sudo /usr/bin/jambulatv-osd -m "$OSD_NOTICE_NO_NETWORK"
# CLI notice
clear && echo "$OSD_NOTICE_NO_NETWORK"

# Restore DVB-T network
sudo /usr/bin/jambulatv-tvheadend-controller dvb all
fi
