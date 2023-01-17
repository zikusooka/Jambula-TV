#!/usr/bin/env bash
#
# Source global settings
PROJECT_NAME=JambulaTV
PROJECT_SYSTEM_CONF_DIR=/etc/$PROJECT_NAME
PROJECT_GLOBAL_SETTINGS_FILE=$PROJECT_SYSTEM_CONF_DIR/global-settings.cfg
. $PROJECT_GLOBAL_SETTINGS_FILE
#
# Variables
TSHARK_MAC_ADDRESS=$(echo "$TSHARK_MAC_ADDRESS" | tr '[:upper:]' '[:lower:]')
MQTT_TOPIC_PRESENCE_TSHARK=JambulaTV/house/presence/tshark/$TSHARK_MAC_ADDRESS


#################
#  MAIN SCRIPT  #
#################
#
# Quit if type of state alert is 'SOFT'
[[ "$HOSTSTATETYPE" = "SOFT" ]] && exit 0

# Publish status via MQTT
if [[ "$HOSTSTATE" = "UP" ]];
then
$MQTT_PUBLISH_CMD $MQTT_PUBLISH_OPTS -t "$MQTT_TOPIC_PRESENCE_TSHARK" -m "Home"

else
$MQTT_PUBLISH_CMD $MQTT_PUBLISH_OPTS -t "$MQTT_TOPIC_PRESENCE_TSHARK" -m "Away"
fi
