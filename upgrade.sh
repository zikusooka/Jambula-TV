#!/bin/sh
PROJECT_NAME=JambulaTV
SOURCESDIR=/opt
PROJECT_BASE_DIR=$SOURCESDIR/$PROJECT_NAME

# Source functions file
. $PROJECT_BASE_DIR/functions



# Upgrade Kodi
upgrade_kodi () {
uninstall_kodi
kodi_install
kodi_addons_install
kodi_customization
kodi_scripts
kodi_lircmap_configure 
}



#################
#  MAIN SCRIPT  #
#################

#upgrade_kodi
