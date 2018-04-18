#!/bin/sh
# Variables
PROJECT_NAME=JambulaTV
SOURCESDIR=/opt
PROJECT_SYSTEM_CONF_DIR=/etc/$PROJECT_NAME
PROJECT_FUNCTIONS_FILE=$PROJECT_SYSTEM_CONF_DIR/functions

# Source functions file
. $PROJECT_FUNCTIONS_FILE



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
kodi_skin_customization
kodi_scripts
IR_REMOTE=
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
#flexget_python2_install
flexget_python3_install
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

upgrade_nextcloud () {
uninstall_nextcloud
nextcloud_install
nextcloud_permissions
nextcloud_configure
}

upgrade_coova_chilli () {
uninstall_coova_chilli
coova_chilli_install
coova_chilli_configure
coova_chilli_customization
}

upgrade_wpa_supplicant () {
uninstall_wpa_supplicant
wpa_supplicant_install
wpa_supplicant_configure
}

upgrade_hostapd () {
uninstall_hostapd
hostapd_install
hostapd_configure 
}

upgrade_hostapd_and_wpa_supplicant () {
uninstall_wpa_supplicant && uninstall_hostapd
[[ -d $INSTALL_SRC_DIR/hostap ]] && rm -rf $INSTALL_SRC_DIR/hostap
upgrade_hostapd
upgrade_wpa_supplicant
}

upgrade_tvheadend () {
systemctl stop tvheadend.service
uninstall_src_pkgs tvheadend
tvheadend_install
}

uninstall_freepbx_if_installed () {
# Remove FreePBX if installed
[[ -x /usr/sbin/fwconsole ]] && uninstall_freepbx
# Remove FreePBX sources if they exist
[[ -d $INSTALL_SRC_DIR/freepbx ]] && rm -rf $INSTALL_SRC_DIR/freepbx
# Remove FreePBX HTML files
[[ -d $WWW_HTML_DIR/freepbx ]] && rm -rf $WWW_HTML_DIR/freepbx
# Remove FreePBX/Asterisk configs if they exist
[[ -d $PROJECT_SYSTEM_CONF_DIR/asterisk.nofreepbx ]] && rm -rf $PROJECT_SYSTEM_CONF_DIR/asterisk.nofreepbx
}

upgrade_freepbx () {
uninstall_freepbx_if_installed
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
#
chan_mobile_configure
chan_motif_configure
asterisk_agi_scripts_install
#
google_tts_configure
picotts_asterisk_configure
}

upgrade_asterisk_and_freepbx () {
upgrade_asterisk
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

upgrade_mplayer () {
uninstall_src_pkgs mplayer
mplayer_install
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

upgrade_yowsup () {
uninstall_python_pkgs yowsup
uninstall_python_pkgs yowsup-cli
yowsup2_install 
}

upgrade_netdata () {
uninstall_netdata
netdata_install
netdata_configure
}

upgrade_pulseaudio () {
uninstall_python_pkgs pyalsaaudio
uninstall_src_pkgs alsa-plugins
uninstall_src_pkgs pulseaudio 
#
pulseaudio_install
alsa_plugins_install
pyalsaaudio_install
}



#################
#  MAIN SCRIPT  #
#################

#upgrade_kernel 4.4.128
#upgrade_kernel 4.9.43

#upgrade_kodi
#upgrade_kodi_addons PLUGIN_1 PLUGIN_2 PLUGIN_3

#FLEXGET_DEPENDENCIES="DEP_1 DEP_2 DEP_3" upgrade_flexget_deps
#upgrade_flexget

#upgrade_icinga2 # Takes ~20 mins
#upgrade_icingaweb2

#upgrade_nextcloud

#upgrade_owncloud 

#upgrade_coova_chilli

#upgrade_wpa_supplicant 

#upgrade_hostapd

#upgrade_hostapd_and_wpa_supplicant

#upgrade_tvheadend

#upgrade_asterisk_and_freepbx

#upgrade_freepbx

#upgrade_asterisk

#upgrade_sphinx

#upgrade_open_zwave
#upgrade_domoticz

#upgrade_zoneminder

#upgrade_x264

#upgrade_ffmpeg

#upgrade_vlc

#upgrade_mplayer

#upgrade_firefox 

#upgrade_youtube_dl 

#upgrade_squid

#upgrade_yowsup

#upgrade_netdata 

#upgrade_pulseaudio
