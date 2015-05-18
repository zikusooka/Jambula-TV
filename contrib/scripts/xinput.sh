#!/bin/sh
REMOTE_DEVICE=/dev/lirc0

export DISPLAY=:0.0
DEVICE_NAME_PATH="/sys`udevadm info -q path -n $REMOTE_DEVICE`/../input*/name"

XINPUT_CMD=/usr/bin/xinput
XINPUT_LINE=`$XINPUT_CMD list | grep "$(cat $DEVICE_NAME_PATH)"`
XINPUT_ID=`expr substr "$XINPUT_LINE" $(expr $(expr index "$XINPUT_LINE" "=") + 1) 100 | awk '{print $1}'`
XINPUT_PROPID=`$XINPUT_CMD list-props $XINPUT_ID | grep Enabled | awk '{print $3}' | sed 's/[^0-9]//g'`



# Disable remote acting as keyboard
$XINPUT_CMD set-prop $XINPUT_ID $XINPUT_PROPID 0
