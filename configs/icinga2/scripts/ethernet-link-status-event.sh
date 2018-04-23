#!/bin/sh
# This script will restart network service if ethernet link is detected.
#
# Variables
SERVICE_DESCRIPTION=$SERVICEDESC
SERVICE_STATE=$SERVICESTATE
SERVICE_DATE=$LONGDATETIME
SERVICE_DISPLAY_NAME=$SERVICEDISPLAYNAME



#################
#  MAIN SCRIPT  #
#################

# Quit if link is OK
if [[ "$SERVICE_STATE" = "OK" ]];
then
exit 0

else
# Restart network service
sudo systemctl restart network.service

# Restart dnsmasq service
sudo systemctl restart dnsmasq.service

# Restart nmb service
sudo systemctl restart nmb.service
fi
