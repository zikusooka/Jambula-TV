#!/usr/bin/env bash
#
# This script checks the status of the DVB-T/2 Live TV streams to see
# if channels are playable where not, restart TVHeadend server
# This is necessiated by very buggy August DVB-T/2 s12168 driver
# which frequently fails
#
# Variables
SERVICE_DESCRIPTION=$SERVICEDESC
SERVICE_STATE=$SERVICESTATE
SERVICE_DATE=$LONGDATETIME
SERVICE_DISPLAY_NAME=$SERVICEDISPLAYNAME



#################
#  MAIN SCRIPT  #
#################

# See if other TV realted maintenance processes are running 
ps auxw | grep '[j]ambulatv-tvheadend-controller' > /dev/null 2>&1
DVB_MAINTENANCE_STATUS=$?

# See if TVheadend systemd unit is running
TVH_SERVICE_ACTIVE=$(sudo /usr/bin/systemctl is-active tvheadend.service)

# Restart TVHeadend server if Live TV streams are not playable
if [[ "$SERVICE_STATE" = "CRITICAL" && "$DVB_MAINTENANCE_STATUS" != "0" && "$TVH_SERVICE_ACTIVE" = "active" ]];
then
/usr/bin/logger -t $(basename $0) -s "Restarting TVHeadend server"
sudo /usr/bin/systemctl restart tvheadend.service
fi
