#!/bin/sh
PROJECT_NAME=JambulaTV
SOURCESDIR=/opt
PROJECT_BASE_DIR=$SOURCESDIR/$PROJECT_NAME

# Source functions file
. $PROJECT_BASE_DIR/functions



# Upgrade Linux Kernel
upgrade_kernel () {
NEW_KERNEL=$1
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

upgrade_kodi_addons () {
KODI_ADDONS_4_UPGRADE=$@
# Uninstall Old
uninstall_kodi_addons $KODI_ADDONS_4_UPGRADE
# Install New
for KODI_ADDON in $KODI_ADDONS_4_UPGRADE; do kodi_addons_unpack $KODI_ADDON; echo; echo "$KODI_ADDON installed, please enter to proceed ..."; echo; read; done
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

upgrade_open_zwave () {
uninstall_python_pkgs open-zwave
rm -f $(which MinOZW ozw_config)
open_zwave_install 
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

upgrade_x264 () {
uninstall_src_pkgs x264
x264_install
}

upgrade_ffmpeg () {
uninstall_src_pkgs ffmpeg
ffmpeg_install
}

upgrade_vlc () {
uninstall_src_pkgs vlc
vlc_install
}

upgrade_firefox () {
uninstall_firefox
firefox_install
}

upgrade_youtube_dl () {
uninstall_youtube_dl
youtube_dl_install
}

upgrade_squid () {
systemctl stop squid.service
uninstall_src_pkgs squid
squid_install
squid_configure
}



#################
#  MAIN SCRIPT  #
#################

#upgrade_kernel 4.4.70

#upgrade_kodi
#upgrade_kodi_addons PLUGIN_1 PLUGIN_2 PLUGIN_3

#FLEXGET_DEPENDENCIES="DEP_1 DEP_2 DEP_3" upgrade_flexget_deps
#upgrade_flexget

#upgrade_icinga2 # Takes ~20 mins
#upgrade_icingaweb2

#upgrade_owncloud 

#upgrade_coova_chilli

#upgrade_hostapd

#upgrade_tvheadend

#upgrade_freepbx

#upgrade_asterisk

#upgrade_sphinx

#upgrade_open_zwave
#upgrade_domoticz

#upgrade_zoneminder

#upgrade_x264

#upgrade_ffmpeg

#upgrade_vlc

#upgrade_firefox 

#upgrade_youtube_dl 

#upgrade_squid
