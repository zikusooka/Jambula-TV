#!/bin/sh
# This script will connect to asterisk server, and dial extension using console
# AEx @ 2009-2010 Copyright  - All rights reserved
###############################################################################
# Usage : $0 [call|hangup] [extension]
ASTERISK_CONNECT_CMD="asterisk -rx" 
ASTERISK_LOG_FILE=/var/log/asterisk/messages
ACTION=$1
EXTENSION=$2

case $ACTION in
call)
$ASTERISK_CONNECT_CMD "console dial $EXTENSION" 
;;
next)
$ASTERISK_CONNECT_CMD "console dial 1" 
;;

hangup)
$ASTERISK_CONNECT_CMD "console hangup" 
;;
esac
