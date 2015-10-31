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

upgrade_flexget_deps () {
#download_flexget_deps
uninstall_flexget_deps 
flexget_deps_install
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

upgrade_owncloud () {
uninstall_owncloud
owncloud_install
}



#################
#  MAIN SCRIPT  #
#################

#upgrade_kodi

#upgrade_flexget_deps 
#upgrade_flexget

#upgrade_icinga2
#upgrade_icingaweb2

#upgrade_owncloud 
