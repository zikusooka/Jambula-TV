#!/bin/sh
#
# This script will run tests to ensure DVB-T tuner is setup correctly.
# Ensure DVBT devices nodes were created 
# Plus ensure that network intvheadend exists and set properly

# Variables
PVR_STATUS_FILE=/tmp/pvr_status # Use the same file in '/usr/bin/jambulatv-kodi-controller'
PVR_STATUS_CMD="/usr/bin/jambulatv-kodi-controller addon_status pvr.hts"

DVBT_TUNER_NAME="Silicon Labs Si2168"
DVBT_NETWORK_NAME="ug-Kampala"
DVBT_PNETWORK_NAME="UBC TX2"

AUTOLOGIN_USER=jambula
AUTOLOGIN_USER_HOME_DIR=$(sudo finger $AUTOLOGIN_USER | grep Directory: | awk {'print $2'})
MULTIMEDIA_USER=$AUTOLOGIN_USER
MULTIMEDIA_USER_HOME_DIR=$AUTOLOGIN_USER_HOME_DIR
TVHEADEND_CONFIG_DIR=$MULTIMEDIA_USER_HOME_DIR/.hts/tvheadend

DVBT_ADAPTER_CONFIG=$(sudo grep -rli "$DVBT_TUNER_NAME" $TVHEADEND_CONFIG_DIR/input/linuxdvb/adapters/ | sudo xargs grep -l adapter0)
DVBT_NETWORK_UUID=$(sudo grep -A 6 "\"displayname\": \"$DVBT_TUNER_NAME : DVB-T #0\"" $DVBT_ADAPTER_CONFIG | tail -1 | awk {'print $1'} | sed "s:\"::g")
DVBT_NETWORK_CONFIG_DIR=$TVHEADEND_CONFIG_DIR/input/dvb/networks
DVBT_NETWORK_CONFIG_FILE=$DVBT_NETWORK_CONFIG_DIR/$DVBT_NETWORK_UUID/config
DVBT_NETWORK_CONFIG_TMP_FILE=/tmp/dvbt_network.config



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
# --------------------------
if [ "$DVBT2_ENABLED" != "y" ];
then
OSD_MESSAGE="TV Tuner was not detected.  Please shutdown and power on again."
#
# Run OSD Message
sudo /usr/bin/jambulatv-osd -m "$OSD_MESSAGE"
fi


# DVB-T Network not found or Test network config file
# ---------------------------------------------------
if [ "$NULL_NETWORK" = "0" ] && [ ! -s $DVBT_NETWORK_CONFIG_FILE ];
then

OSD_MESSAGE="TV Channels list was corrupted possibly due to a bad shutdown previously.  I will attempt to correct it now, please try again shortly"
#
# Run OSD Message
sudo /usr/bin/jambulatv-osd -m "$OSD_MESSAGE"
#
# Restore network
cat > $DVBT_NETWORK_CONFIG_TMP_FILE <<EOF
{
	"networkname": "$DVBT_NETWORK_NAME",
	"pnetworkname": "$DVBT_PNETWORK_NAME",
	"nid": 0,
	"autodiscovery": false,
	"skipinitscan": false,
	"idlescan": false,
	"sid_chnum": false,
	"ignore_chnum": false,
	"satip_source": 0,
	"localtime": false,
	"class": "dvb_network_dvbt"
}
EOF
#
# Move config file from temp to right location
sudo mv -v $DVBT_NETWORK_CONFIG_TMP_FILE $DVBT_NETWORK_CONFIG_FILE
# Change ownership of config file to jambula user
sudo chown $MULTIMEDIA_USER:$MULTIMEDIA_USER $DVBT_NETWORK_CONFIG_FILE
# Restart tvheadend
sudo /usr/bin/systemctl restart tvheadend.service

fi
