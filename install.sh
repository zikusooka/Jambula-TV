#!/bin/sh
# This is the initial file used by JambulaTV installation program.
# It mainly sources routines from the main functions file
#
# Jambula Labs @copyright 2023-2024 All rights reserved

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
#_install_pause_check_4_errors_ "[Insert program name here] Install"

# Fetch project packages
fetch_packages

# Custom kernel install, reboot is needed
kernel_install 

# Info banner
about_install

# Create installation directory
install_dir_create

# Update dtv scan tables
update_dtv_scan_tables

# Ask and set key variables
dvbt_ask_4_variables
dvbt_set_variables

cctv_ask_4_variables

# Non-Interactive install starts here i.e. Start logging to file 
exec 2>> $BUILD_LOG

# Linux tools - selected linux kernel tools
linux_tools_install

# Install current sqlite
sqlite_install

# Install images and icons
images_add

# Install current openssl
openssl111_install

# Install current gnutls
gnutls_install

# Install current curl
curl_install

# Install expat - needed for python3
expat_install

# Install python3
python3_install

# Install meson/ninja
meson_install
ninja_install

# Install waf - used to build mpv
waf_install

# Install current libxml2
libxml2_install

# Install gcc ~53mins
#gcc8_install
#gcc5_install
gcc4_install

# General dependencies
nasm_install
giflib_install 

# mesa
#llvm_install
mesa_deps_install
mesa18_install
#mesa19_install
glu_install

# VA-API/VDPAU
libva_install
libva_utils_install 
intel_vaapi_driver_install
vdpauinfo_install

# Pick desired X11 video driver
case $X11_DRIVER in
intel)
intel_x11_driver_install
;;
nouveau)
nouveau_x11_driver_install
;;
mga)
mga_x11_driver_install
;;
openchrome)
openchrome_x11_driver_install
;;
*)
echo "Using default X11 driver ..."
;;
esac

# Upgrade ccache
ccache_install
# Cmake - using sources
cmake_install
# Boost - using sources
boost_install

# Sound libraries
alsa_lib_install
alsa_utils_install
alsa_oss_install
#ofono_install 
#bluez5_install
#bluez5_configure 
bluez4_install
bluez4_configure
sbc_install
pulseaudio_install
alsa_plugins_install
pyalsaaudio_install
pulseaudio_configure
portaudio_install
oss_devices_configure
SDL_install
openal_soft_install
libass_install
libvdpau_va_gl_install
libbluray_install
ffmpeg_deps_install
ffmpeg_install
vlc_deps_install
vlc_install
#xine_lib_install
#xine_ui_install
mplayer_install
mpv_install
sox_install
v4l_utils_install
tvheadend_install
dvb_drivers_support
w_scan_install
xmltv_install
fmtools_install

# Kodi
kodi_deps_install
#kodi17_install
kodi18_install
kodi_configure
kodi_addons_install
kodi_addons_configure
kodi_skin_customization
kodi_scripts

# Tools used by Kodi
kodi_remote_configure
kodi_osd_configure 
remind_configure 

# X11 setup
x11_superuser_permissions_configure
x11_user_autologin_lxde_configure

# Boot screen customization
plymouth_install
plymouth_configure
grub_settings

# Auto start for JambulaTV
kodi_jambulatv_service_configure

# -----------------
# System Settings
# -----------------
global_settings_configure
bash_configure
release_info_configure
oem_info_configure
updates_server_info_configure
jp2a_install
motd_configure
nfs_server_configure
ieee_oui_configure
wired_interfaces_configure
wireless_drivers_support
wireless_interfaces_configure
assign_ip_2_wifi_gateway_and_enable_nat
openssl_configure
wol_configure 
system_sounds_configure
optical_disc_drive_configure
smartd_setup
# Run these before icinga configure
chrony_configure
dnsmasq_configure
openresolv_install
openresolv_configure
dns_blocking_using_dnsmasq_setup

# -----------------
# Internet Access 
# -----------------
#connectify_configure # Dual WiFi Interfaces # NOTE: Not working, so disabled
internet_mifi_configure # Wifi (mifi)
internet_usb_3g_configure # USB (3G)

# Proxy server support
ziproxy_install
ziproxy_configure

# WAN Accelerator support
squid_install # ~ 65 mins
squid_configure # configured for use by ziproxy WAN accelerator
ziproxy_wan_accel_configure

# ----------------
# Desktop Access
# ----------------
vncserver_configure
desktop_configure
firefox_install
libreoffice_install

# --------------------
# Web/GUI Interfaces
# --------------------
nginx_install
set_www_user_group  # Keep this Active from here-on!!!
nginx_configure
nginx_customization
www_superuser_permissions_configure
php_configure
nginx_fcgiwrap_install
nginx_spawn_fcgi_configure

# ----------
# Databases
# ----------
mysqld_configure

# ------------------------
# Authentication - Radius
# ------------------------
freeradius_install
freeradius_configure
freeradius_attributes_configure
freeradius_test

# --------
# Content
# --------
# DLNA/UPnP
minidlna_install
minidlna_configure
mpd_install
mpd_configure
mpc_install
# Install mopidy deps
#mopidy_deps_install
# Install mopidy
#mopidy_install
snapcast_install 
snapcast_configure

# VoD Streaming
video_on_demand_configure

# Playlists
playlists_configure

# Live TV Configuration DVB-T2, IPTV and JTV Home
tvheadend_configure
iptv_tvheadend_configure
iptv_icons_add 
iptv_builder_install
jtvhome_tvheadend_configure

# Auto download of TV Shows, Movies, and Podcasts
#flexget_deps_install
#flexget_python2_install 
flexget_python3_install 
flexget_configure

# Torrents
xmlrpc_install
libtorrent_install
rtorrent_install
rtorrent_configure
rtgui_configure

# Downloads
aria2_install # ~ 40 mins
aria2_configure

# File server
samba_configure

# -----------------
# Utilities/tools
# -----------------
youtube_dl_install
youtube_setup
streamlink_install
music_download_tool_setup
livestreamer_install
vcfconvert_install
cutter_install 
rtmpdump_install
gnokii_install
gammu_install
email_smtp_install
email_smtp_configure
email_via_gmail_setup
gdata_install
google_sms_setup
sms_tools_setup
twitter_client_setup
reverse_ssh_configure
sshuttle_install
vpn_tunnel_sshuttle_setup
rtl_sdr_install
fm_radio_streamer_setup
internet_radio_streamer_setup 
radio_playlist_setup
TermFeed_install
usbreset_install
screen_resolution_configure
screen_display_configure
screenshots_configure
vnstat_install
vnstat_configure
bwm_ng_install
bandwidth_measurement_setup
trackerjacker_install
trackerjacker_configure
wireshark_install
wireshark_configure
adb_install
adb_sync_setup
libmaxminddb_install
geoipupdate_install
geoipupdate_configure
gplaycli_install
gplaycli_configure
dexMD5_setup
series_cli_install
image_uploader_setup

# ----------------
# Communications 
# ----------------
# IM Chat Server (Needed by XMPP usage in Asterisk)
prosody_install
prosody_configure
prosody_add_users

# Telephone system support
dahdi_install
libpri_install
asterisk_install
asterisk_configure 
# FreePBX GUI
freepbx_preinstall
freepbx_install
freepbx_configure
freepbx_modules
# XMPP
chan_motif_configure
# GSM Trunks/ Mobile Gateways
chan_mobile_configure
chan_dongle_install 
chan_dongle_configure

# AGI scripts 4 JambulaTV
asterisk_agi_scripts_install

# TTS
# Cepstral Support # Not Free!
if [ "$CEPSTRAL_EULA" = "agree" ];
then
cepstral_install 
cepstral_register 
app_swift_install
app_swift_configure
fi

# Google TTS 
google_tts_configure

# Pico TTS by sVox
picotts_install
picotts_asterisk_configure

# JambulaTV TTS
text2speech_setup

# ASR - Speech Recognition
sphinxbase_install
pocketsphinx_install
pocketsphinx_configure
voice_assistant_setup
#SpeechRecognition_install

# -----------------------------------------
# Wireless Access Point (HotSpot)
# IMPORTANT Install After FreePBX/Asterisk
# -----------------------------------------
#coova_chilli_install
#haserl_install
#coova_chilli_configure
#coova_chilli_customization
nodogsplash_install
nodogsplash_configure
nodogsplash_customization 
hostapd_install
hostapd_configure
#wpa_supplicant_install
#wpa_supplicant_configure
iwd_install
iwd_configure
daloradius_configure

# -----------------
# Caching services
# -----------------
redis_install
redis_configure

#------------------
# System Monitoring
# IMPORTANT Install After FreePBX/Asterisk
# -----------------
icinga2_install # ~ 33mins
monitoring_plugins_install
contributed_plugins_install
check_logfiles_install
icinga2_configure
icingaweb2_install
icingaweb2_configure
icinga2_director_install
icinga2_director_configure
#
internet_connectivity_monitoring
#
# Netdata: realtime system monitoring
netdata_install
netdata_configure

# ---------------------
# Security Monitoring 
# IMPORTANT Install After FreePBX/Asterisk
# ---------------------
zoneminder_pre_install
zoneminder_130_install
zoneminder_configure 
zoneminder_zms_inetd
zmeventserver_configure
#
# Cameras via TVHeadend
cctv_tvheadend_configure
cctv_icons_add

# ----------------
# Administration 
# ----------------
# Cloud and Backup support: NextCloud
nextcloud_install
nextcloud_permissions
nextcloud_configure

# ----------------
# Home Automation 
# ----------------
# Domoticz
#domoticz_install # ~ 70mins
#domoticz_configure
#
# OpenHAB
#openhab_install
#openhab_configure
#
# JambulaTV
home_automation_tools
home_automation_services
imobiledevice_install
backup_mobile_phones_setup
#
# HomeAssistant
homeassistant_core_install
homeassistant_core_configure
homeassistant_skin_customization
# HomeAssistant-CLI
homeassistant_cli_install

# ------------------------
# Notifications/ Messaging
# ------------------------
mosquitto_install
mosquitto_configure
#sleekxmpp_install 
python_telegram_bot_install
telegram_messaging_configure
yowsup3_deps_install
yowsup3_python2_install 
whatsapp_messaging_configure

# ---------------
# API based tools
# ---------------
geolocation_api
weather_api

# --------------
# Initial Setup
# --------------
bonjour_configure
initial_setup_configure

# -------
# Updates
# -------
auto_updates_configure

# ---------
# Functions
# ---------
# Copy functions file to project config directory i.e. /etc/JambulaTV
# only if it does not exist
[[ -e $PROJECT_SYSTEM_CONF_DIR/functions ]] || \
cp -v $PROJECT_BASE_DIR/functions $PROJECT_SYSTEM_CONF_DIR

# -----
# Timer
# -----
# How long has this script run?
SCRIPT_RUNTIME=$SECONDS && export SCRIPT_RUNTIME

# ---------
# Notices
# ---------
# Post install Notes
post_install_notice
#

# ---------
# The End
# ---------
