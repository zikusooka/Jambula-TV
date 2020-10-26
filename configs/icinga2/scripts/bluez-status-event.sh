#!/usr/bin/env bash

# Variables
BLUEZ_MAC_ADDRESS=$(echo "$HOSTOUTPUT" | grep -oP "(?<=\[).+?(?=\])")
MQTT_BROKER_IP=127.0.0.1
MQTT_BROKER_PORT=8552
MQTT_PUBLISH_CMD=/usr/bin/mosquitto_pub
MQTT_PUBLISH_OPTS="--quiet -h $MQTT_BROKER_IP -p $MQTT_BROKER_PORT"
MQTT_TOPIC_PRESENCE_BLUEZ=JambulaTV/house/presence/bluez/$BLUEZ_MAC_ADDRESS



# Publish status via MQTT
if [[ "$HOSTSTATE" = "UP" ]];
then
$MQTT_PUBLISH_CMD $MQTT_PUBLISH_OPTS -t "$MQTT_TOPIC_PRESENCE_BLUEZ" -m "on"

else
$MQTT_PUBLISH_CMD $MQTT_PUBLISH_OPTS -t "$MQTT_TOPIC_PRESENCE_BLUEZ" -m "off"
fi
