#!/bin/sh
#
# Jambula Labs @copyright 2023-2024 All rights reserved

# Variables
PROJECT_NAME=JambulaTV
SOURCESDIR=/opt
PROJECT_BASE_DIR=$SOURCESDIR/$PROJECT_NAME
UPGRADING=yes

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
uninstall_openssl111
openssl111_install
}

# Upgrade Python 3
upgrade_python3 () {
uninstall_python3
python3_install 3.11
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

upgrade_boost () {
uninstall_boost
boost_install
}

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
IR_REMOTE="vr-1100" && uninstall_src_pkgs inputlirc > /dev/null 2>&1 && kodi_remote_configure
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
# Set flexget tag
if [[ "x$1" != "x" ]];
then
NEW_FLEXGET_TAG=$1
else
NEW_FLEXGET_TAG=$(cd $PROJECT_GITHUB_DIR/Flexget && git describe --tags $(git rev-list --tags --max-count=1))
fi
# Python 3 binary version 
if [[ "x$2" != "x" ]];
then
PYTHON3_BINARY="$2"
else
PYTHON3_BINARY="$FLEXGET_PYTHON3_BINARY_DEFAULT"
fi
#
FLEXGET_OLD_VERSION=$3
#
# Uninstall old flexget
uninstall_flexget $FLEXGET_OLD_VERSION
#
# Install latest flexget
flexget_python3_install "$NEW_FLEXGET_TAG" "$PYTHON3_BINARY"
}

upgrade_icinga2 () {
# Backup icinga2 hosts.conf file
[[ -s $ICINGA2_CUSTOM_CONFIG_DIR/hosts.conf ]] && \
	cp -v $ICINGA2_CUSTOM_CONFIG_DIR/hosts.conf $TMPDIR/icinga2-hosts.conf
#
uninstall_icinga2
icinga2_install
icinga2_configure
#
# Restore icinga2 hosts file
[[ -s $TMPDIR/icinga2-hosts.conf ]] && \
	cp -v $TMPDIR/icinga2-hosts.conf $ICINGA2_CUSTOM_CONFIG_DIR/hosts.conf 
#
# Enable icinga2.service - ONLY for upgrades
systemctl enable icinga2.service
systemctl restart icinga2.service
}

upgrade_icinga2_director () {
uninstall_icinga2_director
icinga2_director_install
icinga2_director_configure
}

upgrade_icingaweb2 () {
uninstall_icingaweb2
icingaweb2_install
icingaweb2_configure
upgrade_icinga2_director
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

upgrade_iwd () {
uninstall_iwd
iwd_install
iwd_configure
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
# Restart systemd unit 
systemctl restart tvheadend.service
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
uninstall_open_zwave
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
NEW_HOME_ASSISTANT_TAG=$(cd $PROJECT_GITHUB_DIR/home-assistant-core && git describe --tags $(git rev-list --tags --max-count=1))0
fi
# Python 3 binary version 
if [[ "x$2" != "x" ]];
then
PYTHON3_BINARY="$2"
else
PYTHON3_BINARY="$HOMEASSISTANT_PYTHON3_BINARY_DEFAULT"
fi
#
HOME_ASSISTANT_OLD_VERSION=$3
#
# Generate this HASS version's extra requirements file
HASS_INSTALL_REQUIREMENTS_OLD_VERSION_FILE=$PROJECT_PIPS_REQUIRES_DIR/home-assistant-core-requirements-${HOME_ASSISTANT_OLD_VERSION}.txt
HASS_INSTALL_REQUIREMENTS_NEW_VERSION_FILE=$PROJECT_PIPS_REQUIRES_DIR/home-assistant-core-requirements-$(echo $NEW_HOME_ASSISTANT_TAG | sed "s/\.//g").txt
#
REQUIREMENTS_FILE=$PROJECT_GITHUB_DIR/home-assistant-core/requirements.txt
REQUIREMENTS_CONSTRAINTS_FILE=$PROJECT_GITHUB_DIR/home-assistant-core/homeassistant/package_constraints.txt
REQUIREMENTS_ALL_FILE=$PROJECT_GITHUB_DIR/home-assistant-core/requirements_all.txt
#
if [[ ! -e $HASS_INSTALL_REQUIREMENTS_NEW_VERSION_FILE ]] && [[ -e $HASS_INSTALL_REQUIREMENTS_OLD_VERSION_FILE ]];
then
for PKG in $(cat $HASS_INSTALL_REQUIREMENTS_OLD_VERSION_FILE | cut -d "=" -f1 );
do
NEW_PKG=$(grep -r $PKG $REQUIREMENTS_FILE $REQUIREMENTS_CONSTRAINTS_FILE $REQUIREMENTS_ALL_FILE | cut -d ":" -f2 | uniq | sed "/^#/d" | head -1)
[[ "x$NEW_PKG" = "x" ]] || echo "$NEW_PKG" >> $HASS_INSTALL_REQUIREMENTS_NEW_VERSION_FILE
done
fi
#
# Uninstall old homeassistant
uninstall_homeassistant_core $HOME_ASSISTANT_OLD_VERSION
#
# Install latest homeassistant
homeassistant_core_install "$NEW_HOME_ASSISTANT_TAG" "$PYTHON3_BINARY"

# Source HASS runtime variables
. $SYSCONFIG_DIR/home-assistant-core
#
# Sync old HASS configuration files into new version's configuration directory	
rsync -av $PROJECT_SYSTEM_CONF_DIR/homeassistant-${HOME_ASSISTANT_OLD_VERSION}/ $HOME_ASSISTANT_CONFIG_DIR/ 
# Create symbolic link to HASS config directory - needed by some tools that don't know about version info
ln -s -f $HOME_ASSISTANT_CONFIG_DIR $PROJECT_SYSTEM_CONF_DIR/homeassistant
}

upgrade_homeassistant_cli () {
uninstall_homeassistant_cli
homeassistant_cli_install
}

upgrade_zoneminder () {
ZM_ADD_DEFAULT_MONITORS=yes 
uninstall_zoneminder
zoneminder_130_install
zoneminder_configure 
zoneminder_zms_inetd
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
# Uninstall yowsup python2
uninstall_python_pkgs yowsup python2
[[ -d $INSTALL_SRC_DIR/yowsup ]] && rm -rf $INSTALL_SRC_DIR/yowsup
rm -f $(whereis yowsup-cli)
# Uninstall consonance python2
uninstall_python_pkgs consonance python2
[[ -d $INSTALL_SRC_DIR/consonance ]] && rm -rf $INSTALL_SRC_DIR/consonance
# Install consonance
python_consonance_install $PYTHON_CONSONANCE_VERSION
# Install yowsup
yowsup3_python2_install
}

upgrade_netdata () {
uninstall_netdata
netdata_install
netdata_configure
}

upgrade_pulseaudio () {
uninstall_src_pkgs fluidsynth
uninstall_python_pkgs pyalsaaudio
uninstall_src_pkgs alsa-plugins
systemctl stop pulseaudio.service || killall pulseaudio
uninstall_src_pkgs pulseaudio && rm -rf $LIBDIR/pulse-*
#
pulseaudio_install
alsa_plugins_install
pyalsaaudio_install
fluidsynth_install
pulseaudio_configure
}

upgrade_live555 () {
uninstall_live555
live555_install
}

upgrade_mesa () {
uninstall_src_pkgs mesa
mesa18_install
#mesa19_install
}

upgrade_mopidy () {
uninstall_mopidy
uninstall_mopidy_deps
mopidy_deps_install
mopidy_install
}

upgrade_snapcast () {
uninstall_snapcast
snapcast_install
}

upgrade_nginx () {
uninstall_nginx
nginx_install
}

upgrade_v4l_utils () {
uninstall_src_pkgs v4l-utils
v4l_utils_install
}

upgrade_rtorrent () {
uninstall_src_pkgs rtorrent
uninstall_src_pkgs libtorrent
libtorrent_install
rtorrent_install 
}

upgrade_prosody () {
clear
cat <<ET
WARNING: This will remove all previously configured user accounts and certificates!

Are you sure you want to proceed? If Yes, press 'Enter' else 'Ctrl+C'
ET
read
uninstall_prosody
prosody_install
prosody_configure
prosody_add_users
}



#################
#  MAIN SCRIPT  #
#################
#DEBUGGING
#_install_pause_check_4_errors_ $PROJECT_ATTENDANT_USERNAME $PROJECT_ATTENDANT_HOSTNAME "Insert program name here"

#upgrade_kernel 5.10.43
#upgrade_kernel 5.4.253
#upgrade_kernel 4.19.194
#upgrade_kernel 4.14.236
#upgrade_kernel 4.9.272
#upgrade_kernel 4.4.272

#upgrade_openssl

#upgrade_python3

#upgrade_scapy

#upgrade_boost # Takes ~35mins

#upgrade_kodi # Takes ~ 3hrs 9mins
#upgrade_kodi_addons PLUGIN_1 PLUGIN_2 PLUGIN_3

#FLEXGET_DEPENDENCIES="DEP_1 DEP_2 DEP_3" upgrade_flexget_deps
#upgrade_flexget "v3.3.2" "python3.8" "v332"
#upgrade_flexget "v3.7.0" "python3.11" "v370"

#upgrade_icinga2
#upgrade_icingaweb2

#upgrade_nextcloud

#upgrade_owncloud 

#upgrade_coova_chilli

#upgrade_wpa_supplicant 

#upgrade_iwd

#upgrade_hostapd

#upgrade_hostapd_and_wpa_supplicant

#upgrade_tvheadend

#upgrade_asterisk_and_freepbx

#upgrade_freepbx

#upgrade_asterisk

#upgrade_sphinx

#upgrade_open_zwave
#upgrade_domoticz

#upgrade_homeassistant 2023.7.1 python3.11 202362
#upgrade_homeassistant 2021.7.3 python3.8 202171
#upgrade_homeassistant 2023.8.2 python3.11 202371

#upgrade_homeassistant_cli

#upgrade_zoneminder

#upgrade_x264

#upgrade_ffmpeg

#upgrade_vlc # Takes ~105mins

#upgrade_mplayer

#upgrade_mpv

#upgrade_firefox 

#upgrade_youtube_dl 

#upgrade_squid

#upgrade_yowsup # Remember to set version of consonance in functions

#upgrade_netdata 

#upgrade_pulseaudio

#upgrade_live555 

#upgrade_mesa

#upgrade_mopidy

#upgrade_snapcast

#upgrade_nginx

#upgrade_v4l_utils

#upgrade_rtorrent

#upgrade_prosody
