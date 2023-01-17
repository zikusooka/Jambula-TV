#!/usr/bin/env bash
#
# Source global settings
PROJECT_NAME=JambulaTV
PROJECT_SYSTEM_CONF_DIR=/etc/$PROJECT_NAME
PROJECT_GLOBAL_SETTINGS_FILE=$PROJECT_SYSTEM_CONF_DIR/global-settings.cfg
. $PROJECT_GLOBAL_SETTINGS_FILE
#
# Variables
BLUEZ_MAC_ADDRESS=$(echo "$BLUEZ_MAC_ADDRESS" | tr '[:upper:]' '[:lower:]')
MQTT_TOPIC_PRESENCE_BLUEZ=JambulaTV/house/presence/bluez/$BLUEZ_MAC_ADDRESS


#################
#  MAIN SCRIPT  #
#################
#
# Quit if type of state alert is 'SOFT'
[[ "$HOSTSTATETYPE" = "SOFT" ]] && exit 0

# Publish status via MQTT
if [[ "$HOSTSTATE" = "UP" ]];
then
$MQTT_PUBLISH_CMD $MQTT_PUBLISH_OPTS -t "$MQTT_TOPIC_PRESENCE_BLUEZ" -m "Home"

else
$MQTT_PUBLISH_CMD $MQTT_PUBLISH_OPTS -t "$MQTT_TOPIC_PRESENCE_BLUEZ" -m "Away"
fi
