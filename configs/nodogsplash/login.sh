#!/bin/sh
# This script is our adaptation of nodogsplash's [login.sh] script
#
# Jambula Labs @copyright 2019-2020 All rights reserved


# Variables sent by nodogsplash process
# -------------------------------------
# Get the urlencoded querystring
query_enc="$1"

# The query string is sent to us from NDS in a urlencoded form,
# so we must decode it here so we can parse it:
query=$(printf "${query_enc//%/\\x}")

# Parse for the system variables always sent by NDS:
clientip="$(echo $query | awk -F ', ' '{print $1;}' | awk -F 'clientip=' '{print $2;}')"
gatewayname="$(echo $query | awk -F ', ' '{print $2;}' | awk -F 'gatewayname=' '{print $2;}')"

# The third system variable is either the originally requested url:
requested="$(echo $query | awk -F ', ' '{print $3;}' | awk -F 'redir=' '{print $2;}')"

# or it is a status message:
status="$(echo $query | awk -F ', ' '{print $3;}' | awk -F 'status=' '{print $2;}')"


# Source our custom JambulaTV functions for Nodogsplash
# -----------------------------------------------------
. /etc/JambulaTV/nodogsplash/functions


# Check if user already logged in and has tapped "back" on browser
# ----------------------------------------------------------------
if [[ $status == "authenticated" ]]; 
then
jambula_already_logged_in 
exit 0
fi


# Get client's info upon authentication, and parse accordingly
# ------------------------------------------------------------
varlist="id ip mac added active duration token state downloaded avg_down_speed uploaded avg_up_speed"
clientinfo=$($NDS_CONTROL_CMD json $clientip)

if [[ -z "$clientinfo" ]]; 
then
jambula_portal_busy
exit 0

else
for var in $varlist; 
do
eval $var=$(echo "$clientinfo" | grep $var | awk -F'"' '{print $4}')
done
fi

# Get token and MAC address
tok=$token
clientmac=$mac

# Display landing page depending on availability of Internet
# ----------------------------------------------------------
# check for DNS connectivity
jambula_check_dns
#
# Check if Internet is ON
if [ "$DNS_STATUS" = "0" ];
then
# Internet On
jambula_header 
jambula_body_template "landing/post_auth_splash_internet_on" 1
jambula_footer

else
# Internet off
jambula_header 
jambula_body_template "landing/post_auth_splash_internet_off" 1
jambula_footer
fi


# Trust WiFi devices that were initially setup and registered
# -----------------------------------------------------------
jambula_add_legal_device $clientmac


# Log MAC addresses of all clients who are granted access
# -------------------------------------------------------
jambula_log_clients $clientmac
