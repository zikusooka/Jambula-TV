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
kodi_pvr_hts_install
kodi_addons_install
kodi_customization
kodi_scripts
kodi_lircmap_configure 
}

upgrade_flexget () {
uninstall_flexget
flexget_install
}

upgrade_icinga2 () {
uninstall_icinga2 
icinga2_install
icinga2_ido_mysql 
icinga2_configure 
}

upgrade_icingaweb2 () {
uninstall_icingaweb2
icingaweb2_install
icingaweb2_configure 
}



#################
#  MAIN SCRIPT  #
#################

#upgrade_kodi

#upgrade_flexget

#upgrade_icinga2
#upgrade_icingaweb2

