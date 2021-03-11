#!/usr/bin/env bash
#
# Source global settings
PROJECT_NAME=JambulaTV
PROJECT_SYSTEM_CONF_DIR=/etc/$PROJECT_NAME
PROJECT_GLOBAL_SETTINGS_FILE=$PROJECT_SYSTEM_CONF_DIR/global-settings.cfg
. $PROJECT_GLOBAL_SETTINGS_FILE
#
# Variables
BLUEZ_MAC_ADDRESS=$(echo "$HOSTOUTPUT" | grep -oP "(?<=\[).+?(?=\])")
MQTT_TOPIC_PRESENCE_BLUEZ=JambulaTV/house/presence/bluez/$BLUEZ_MAC_ADDRESS

# Publish status via MQTT
if [[ "$HOSTSTATE" = "UP" ]];
then
$MQTT_PUBLISH_CMD $MQTT_PUBLISH_OPTS -t "$MQTT_TOPIC_PRESENCE_BLUEZ" -m "on"

else
$MQTT_PUBLISH_CMD $MQTT_PUBLISH_OPTS -t "$MQTT_TOPIC_PRESENCE_BLUEZ" -m "off"
fi
