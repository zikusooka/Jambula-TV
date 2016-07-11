#!/bin/sh
PROJECT_NAME=JambulaTV
SOURCESDIR=/opt
PROJECT_BASE_DIR=$SOURCESDIR/$PROJECT_NAME

# Source functions file
. $PROJECT_BASE_DIR/functions



# Upgrade Linux Kernel
upgrade_kernel () {
NEW_KERNEL=4.1.27
#
kernel_upgrade_1
kernel_upgrade_2
}

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

upgrade_coova_chilli () {
uninstall_coova_chilli
coova_chilli_install
coova_chilli_configure
coova_chilli_customization
}

upgrade_hostapd () {
uninstall_hostapd
hostapd_install
hostapd_configure 
}

upgrade_tvheadend () {
systemctl stop tvheadend.service
uninstall_src_pkgs tvheadend
tvheadend_install
}

upgrade_freepbx () {
uninstall_freepbx
freepbx_preinstall
freepbx_install
freepbx_configure
freepbx_modules
}

upgrade_asterisk () {
#download_asterisk_deps
uninstall_asterisk
uninstall_dahdi
uninstall_libpri
dahdi_install
libpri_install
asterisk_install 
asterisk_configure 
upgrade_freepbx
}

upgrade_sphinx () {
uninstall_pocketsphinx
uninstall_sphinxbase
sphinxbase_install
pocketsphinx_install
}

upgrade_domoticz () {
uninstall_domoticz
domoticz_install
domoticz_configure
}

upgrade_zoneminder () {
uninstall_zoneminder
#zoneminder_128_install
zoneminder_130_install
zoneminder_configure 
}



#################
#  MAIN SCRIPT  #
#################

#upgrade_kernel

#upgrade_kodi

#upgrade_flexget_deps 
#upgrade_flexget

#upgrade_icinga2
#upgrade_icingaweb2

#upgrade_owncloud 

#upgrade_coova_chilli

#upgrade_hostapd

#upgrade_tvheadend

#upgrade_freepbx

#upgrade_asterisk

#upgrade_sphinx

#upgrade_domoticz

#upgrade_zoneminder
