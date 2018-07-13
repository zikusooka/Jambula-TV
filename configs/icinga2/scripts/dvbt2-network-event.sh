#!/bin/sh
# This script will run tests to ensure DVB-T tuner is setup correctly.
# Ensure DVBT devices nodes were created 
# Plus ensure that DVBT network in tvheadend exists and is setup properly
#
# Variables
SERVICE_DESCRIPTION=$SERVICEDESC
SERVICE_STATE=$SERVICESTATE
SERVICE_DATE=$LONGDATETIME
SERVICE_DISPLAY_NAME=$SERVICEDISPLAYNAME

SERVICE_REPAIR_COMMAND="/usr/bin/jambulatv-tvheadend-controller dvb repair"
SERVICE_REPAIR_LOG_DIR="/var/log/JambulaTV/tvheadend"
SERVICE_REPAIR_LOG_FILE="$SERVICE_REPAIR_LOG_DIR/dvb-repair.log"



#################
#  MAIN SCRIPT  #
#################

if [[ "$SERVICE_STATE" = "CRITICAL" ]];
then

# Add base directory if non existent
[[ -d $SERVICE_REPAIR_LOG_DIR ]] || mkdir -p $SERVICE_REPAIR_LOG_DIR
# Add log file, if non-existent
[[ -e $SERVICE_REPAIR_LOG_FILE ]] || sudo touch $SERVICE_REPAIR_LOG_FILE
# Give icinga permsions to this file
[[ -e $SERVICE_REPAIR_LOG_FILE ]] && sudo chown $(whoami) $SERVICE_REPAIR_LOG_FILE

# Add start datestamp to log file
cat >> $SERVICE_REPAIR_LOG_FILE <<EOT

===============================================================================
DVB-T Network Repair done on:		$(date)
===============================================================================

EOT

# Run DVB-T network repair tool
sudo $SERVICE_REPAIR_COMMAND >> $SERVICE_REPAIR_LOG_FILE 2>&1
fi
