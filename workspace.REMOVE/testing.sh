#!/bin/sh
PROJECT_NAME=JambulaTV
SOURCESDIR=/opt
PROJECT_BASE_DIR=$SOURCESDIR/$PROJECT_NAME

# Source functions file
. $PROJECT_BASE_DIR/functions



#################
#  MAIN SCRIPT  #
#################
#
# Modify chilli config file: UAM, radius passwords, etc...
# *******************************************************
cat $PROJECT_CONFIGS_DIR/coova-config.template | \
sed -e "s/INTERNET_GATEWAY_DEV/$NETWORK_ETHERNET_DEVICE/" | \
sed -e "s/WIRELESS_DEV/$WIFI_AP_INTERFACE/" | \
sed -e "s/HSSECRET/$COOVA_UAM_SECRET/" | \
sed -e "s/RADIUSSECRET/$FREERADIUS_DB_PASS/" | \
sed -e "s/HOST_IP/$COOVA_SERVER_IP/" | \
sed -e "s/JAMBULATV/$COOVA_SERVER_IP/" | \
sed -e "s/NETWORKSSID/$NETWORK_WIRELESS_SSID/" | \
sed -e "s/jambulatv.com/$NETWORK_DOMAIN/" | \
sed -e "s/DNS_SERVER_1/$NETWORK_DNS_1/" | \
sed -e "s/DNS_SERVER_2/$NETWORK_DNS_2/" | \
sed -e "s/HOTSPOT_SSID/$NETWORK_WIRELESS_SSID/" | \
sed -e "s/HOTSPOT_LOCATION/$COMPANY_NAME/" | \
sed -e "s/HOTSPOT_NETWORK/$NETWORK_WIRELESS_SSID/" | \
sed -e "s/NAS_MAC_ADDRESS/$WIFI_AP_MACADDRESS/" | \
sed -e "s/NAS_IP_ADDRESS/$COOVA_SERVER_IP/" | \
sed -e "s/# HS_ADMUSR=chillispot/HS_ADMUSR=$FREERADIUS_ADMIN_USER/" | \
sed -e "s/# HS_ADMPWD=chillispot/HS_ADMPWD=$FREERADIUS_ADMIN_PASS/" | \
sed -e "s/# HS_TCP_PORTS=\"80 443\"/HS_TCP_PORTS=\"$COOVA_OPEN_TCP_PORTS\"/" | \
sed -e "s/ALLOWED_MAC_ADDRESSES/\"$COOVA_PRIVILEGED_MAC\"/" \
	> $COOVA_CONFIG_FILE


