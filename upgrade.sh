#!/bin/sh
# Variables
PROJECT_NAME=JambulaTV
SOURCESDIR=/opt
PROJECT_BASE_DIR=$SOURCESDIR/$PROJECT_NAME

# Source functions file
. $PROJECT_BASE_DIR/functions



#################
#  MAIN SCRIPT  #
#################
#DEBUGGING
#_install_pause_check_4_errors_ "[Insert program name here] Upgrade"

# Upgrade Linux Kernel
upgrade_kernel () {
NEW_KERNEL=$1
kernel_upgrade_1
kernel_upgrade_2
}

# Upgrade OpenSSL
upgrade_openssl () {
uninstall_src_pkgs openssl
openssl111_install
}

# Upgrade Python 3
upgrade_python3 () {
uninstall_python3
python3_install
}

upgrade_scapy () {
# Uninstall current scapy version
uninstall_python_pkgs scapy
uninstall_python_pkgs UTscapy
#
# Install scapy if it is not installed
echo "Checking if scapy is installed ..."
pip3 show scapy > /dev/null 2>&1
SCAPY_EXISTS=$?
if [[ "$SCAPY_EXISTS" != "0" ]];
then
scapy_install 
fi
}

# Upgrade Kodi
upgrade_kodi () {
#uninstall_kodi17
#kodi17_install
uninstall_kodi18
kodi18_install
kodi_configure
kodi_addons_install
kodi_addons_configure
kodi_skin_customization
kodi_scripts
IR_REMOTE="vr-100" && kodi_remote_configure
}

upgrade_kodi_addons () {
KODI_ADDONS_4_UPGRADE=$@
# Uninstall Old
uninstall_kodi_addons $KODI_ADDONS_4_UPGRADE
#
# Install New
for KODI_ADDON in $KODI_ADDONS_4_UPGRADE
do
kodi_addons_unpack $KODI_ADDON
echo
echo "$KODI_ADDON installed, please enter to proceed ..."
echo
read
#
# Create script to enable addon 
cat >> $TMPDIR/jambula_addons2enable <<EOT
sqlite3 $KODI_USER_DATA/Database/Addons27.db 'update installed set enabled=1 where addonid=='"'$KODI_ADDON'"';'
EOT
done
#
# Run script i.e. enable addon
sh $TMPDIR/jambula_addons2enable
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

upgrade_homeassistant () {
# Set homeassistant tag
if [[ "x$1" != "x" ]];
then
NEW_HOME_ASSISTANT_TAG=$1
else
NEW_HOME_ASSISTANT_TAG=$HOME_ASSISTANT_TAG
fi
# Uninstall old homeassistant
uninstall_homeassistant
# Install latest homeassistant
HOME_ASSISTANT_TAG=$NEW_HOME_ASSISTANT_TAG && \
	homeassistant_install 
}

upgrade_homeassistant_cli () {
uninstall_homeassistant_cli
homeassistant_cli_install
}

upgrade_zoneminder () {
uninstall_zoneminder
#zoneminder_128_install
zoneminder_130_install
zoneminder_configure
zmeventserver_configure
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

upgrade_mpv () {
uninstall_mpv
mpv_install
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
yowsup3_python2_install 
#yowsup2_python3_install
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

upgrade_live555 () {
uninstall_live555
live555_install
}

upgrade_mesa () {
uninstall_src_pkgs mesa
mesa_install
}

upgrade_mopidy () {
uninstall_mopidy
uninstall_mopidy_deps
mopidy_deps_install
mopidy_install
}



#################
#  MAIN SCRIPT  #
#################
#DEBUGGING
#_install_pause_check_4_errors_ $PROJECT_ATTENDANT_USERNAME $PROJECT_ATTENDANT_HOSTNAME "Insert program name here"

#upgrade_kernel 4.20
#upgrade_kernel 4.19.60
#upgrade_kernel 4.4.174

#upgrade_openssl

#upgrade_python3

#upgrade_scapy

#upgrade_kodi
#upgrade_kodi_addons PLUGIN_1 PLUGIN_2 PLUGIN_3

#FLEXGET_DEPENDENCIES="DEP_1 DEP_2 DEP_3" upgrade_flexget_deps
#upgrade_flexget

#upgrade_icinga2 
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

#upgrade_homeassistant
#upgrade_homeassistant_cli

#upgrade_zoneminder

#upgrade_x264

#upgrade_ffmpeg

#upgrade_vlc

#upgrade_mplayer

#upgrade_mpv

#upgrade_firefox 

#upgrade_youtube_dl 

#upgrade_squid

#upgrade_yowsup

#upgrade_netdata 

#upgrade_pulseaudio

#upgrade_live555 

#upgrade_mesa

#upgrade_mopidy
