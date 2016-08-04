#!/bin/sh
#
PVR_STATUS_FILE=/tmp/pvr_status # Use the same file in '/usr/bin/jambulatv-kodi-controller'
PVR_STATUS_CMD="/usr/bin/jambulatv-kodi-controller pvr_hts_status"



######################
#  PVR Status Query  #
######################
# Run command
$PVR_STATUS_CMD
# Pull Status
. $PVR_STATUS_FILE

# Quit if Kodi PVR Manager is not enabled
[ "$PVR_HTS_STATUS" != "false" ] || exit 0



#################
#  MAIN SCRIPT  #
#################
# Set to y if DVB-T is enabled 
[ -d /dev/dvb ] && DVBT2_ENABLED=y
# Query channel list
wget -q -O - localhost:9981/api/channel/list | jq . | grep \"val\" | awk {'print $2'} | sed 's:[{|}|"|,]::g' | grep 'name-not-set' > /dev/null 2>&1
NULL_NETWORK=$?

# DVB-T Tuner node not found
if [ "$DVBT2_ENABLED" != "y" ];
then
OSD_MESSAGE="TV Tuner was not detected.  Please shutdown and power on again."
#
# Run OSD Message
/usr/bin/jambulatv-osd -m "$OSD_MESSAGE"
fi


# DVB-T Network not found
if [ "$NULL_NETWORK" = "0" ];
then
OSD_MESSAGE="TV Channels list was corrupted possibly due to a bad shutdown previously.  I will attempt to correct it now, please try again shortly"
#
# Run OSD Message
/usr/bin/jambulatv-osd -m "$OSD_MESSAGE"
#
# Restore network
sudo /usr/bin/rsync -aqv --delete /JambulaTV/.hts.bak/ /JambulaTV/.hts/
sudo /usr/bin/systemctl restart tvheadend.service
fi
