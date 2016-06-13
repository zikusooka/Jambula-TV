#!/bin/sh
PROJECT_NAME=JambulaTV
SOURCESDIR=/opt
PROJECT_BASE_DIR=$SOURCESDIR/$PROJECT_NAME

# Source functions file
. $PROJECT_BASE_DIR/functions

# My credentials - Remove before shipping!!!
TRAKT_USERNAME=dc8982
TRAKT_WATCHLIST=JambulaTV
TORRENTS_DOMAIN_NAME=JambulaTV
GOOGLE_SERVICES_USERNAME="smtprelayug@gmail.com"
GOOGLE_SERVICES_PASSWORD="256smtprelayug"
EMAIL_TO_ADDRESS="joseph@zikusooka.com"
TELEGRAM_API_BOT="189563360:AAFFiDHQXgBTLSPsdVbXDbMkG-khkIGlqa8"
TELEGRAM_USERNAME="jlabs"



#################
#  MAIN SCRIPT  #
#################
# Add Jambula customized advancedsettings file
cat $PROJECT_CONFIGS_DIR/kodi/advancedsettings.xml | \
	sed "s:KODI_DB_VIDEO:$KODI_DB_VIDEO:g" | \
	sed "s:KODI_DB_MUSIC:$KODI_DB_MUSIC:g" | \
	sed "s:KODI_DB_USER:$KODI_DB_USER:g" | \
	sed "s:KODI_DB_PASS:$KODI_DB_PASS:g" \
	> /tmp/advancedsettings.xml
# Add Jambula customized guisettings file
cat $PROJECT_CONFIGS_DIR/kodi/guisettings.xml | \
	sed -e "s:KODI_HTTP_USER:$KODI_HTTP_USER:g" | \
   	sed -e "s:KODI_HTTP_PASS:$KODI_HTTP_PASS:g" | \
	sed -e "s:KODI_HTTP_PORT:$KODI_HTTP_PORT:g" | \
   	sed -e "s:SMB_WORKGROUP:$SMB_WORKGROUP:g" \
	> /tmp/guisettings.xml
#
