#!/usr/bin/env bash
#
# Source global settings
PROJECT_NAME=JambulaTV
PROJECT_SYSTEM_CONF_DIR=/etc/$PROJECT_NAME
PROJECT_GLOBAL_SETTINGS_FILE=$PROJECT_SYSTEM_CONF_DIR/global-settings.cfg
. $PROJECT_GLOBAL_SETTINGS_FILE
#
# Variables
WIFI_AP_NAME=$(echo "$WIFI_AP_SSID" | tr '[:upper:]' '[:lower:]')
MQTT_TOPIC_PRESENCE_WIFI_AP=JambulaTV/house/presence/wifi_ap/$WIFI_AP_NAME

INTERNET_WIFI_ISP_CONFIG=/etc/JambulaTV/internet-mobile-wifi.cfg
PREFERRED_WIFI_AP_SSID=$(grep -i SSID $INTERNET_WIFI_ISP_CONFIG | sed '/^#/d' | cut -d = -f2 | sed 's/"//g')


#################
#  MAIN SCRIPT  #
#################
#
# Quit if type of state alert is 'SOFT'
[[ "$HOSTSTATETYPE" = "SOFT" ]] && exit 0

# Publish status via MQTT
if [[ "$HOSTSTATE" = "UP" ]];
then
$MQTT_PUBLISH_CMD $MQTT_PUBLISH_OPTS -t "$MQTT_TOPIC_PRESENCE_WIFI_AP" -m "Home"
else
$MQTT_PUBLISH_CMD $MQTT_PUBLISH_OPTS -t "$MQTT_TOPIC_PRESENCE_WIFI_AP" -m "Away"
fi

# Connect to WiFi AP point if it is a preferred one
if [[ "$WIFI_AP_SSID" = "$PREFERRED_WIFI_AP_SSID" ]];
then
sudo /usr/bin/jambulatv-connect-2-wifi-ap $HOSTSTATE
fi
