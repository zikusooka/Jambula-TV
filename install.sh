#!/bin/sh
PROJECT_NAME=JambulaTV
SOURCESDIR=/opt
PROJECT_BASE_DIR=$SOURCESDIR/$PROJECT_NAME

# Source functions file
. $PROJECT_BASE_DIR/functions



#################
#  MAIN SCRIPT  #
#################

# Install custom kernel
kernel_install 

# Create installation directory
install_dir_create

# pick desired X11 video driver
case $X11_DRIVER in
intel)
intel_x11_driver_install uxa # Add Video Acceleration as argument
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
ffmpeg_deps_install
live555_install
libdvbpsi_install 
#
# Install ffmpeg first without x264 - will be removed and re-installed shortly
#ffmpeg_install && x264_install 
# Uninstall already existing ffmpeg (without x264 libs) and install agian w/ x264
#uninstall_src_pkgs ffmpeg && ffmpeg_install
#
ffmpeg_install
x264_install
vlc_install
xine_lib_install
xine_ui_install
mplayer_install
sox_install
v4l_utils_install
tvheadend_install
tvheadend_configure
fmtools_install

# Kodi Dependencies 
kodi_deps_install
# Kodi (formerly XBMC)
kodi_install # Takes ~160 minutes
kodi_pvr_hts_install
kodi_addons_install
kodi_configure
kodi_customization
kodi_scripts

# Tools used by Kodi
kodi_remote_configure
kodi_osd_configure 
remind_configure 

# X11 setup
x11_server_configure
x11_superuser_permissions_configure
x11_user_autologin_lxde_configure

# Boot screen customization
plymouth_customization
grub_settings

# Auto start for JambulaTV
kodi_jambulatv_service_configure

# -----------------
# System Settings
# -----------------
boot_optimization
wired_interfaces_configure
wireless_interfaces_configure
openssl_configure
wol_configure 
beep_spkr_configure # Alert sounds - beep2_install no longer needed
# Run these before icinga configure
chrony_configure
dnsmasq_configure
openresolv_install
openresolv_configure

# -----------------
# Internet Access 
# -----------------
# Dual virtual interfaces
virtual_wifi_interfaces_configure
internet_mifi_configure # Wifi (mifi)
internet_usb_3g_configure # USB (3G)

# Proxy server support
ziproxy_install
ziproxy_configure

# WAN Accelerator support
squid_install # Takes a very long time ~ 50 mins
squid_configure # configured for use by ziproxy WAN accelerator
ziproxy_wan_accel_configure

# ----------------
# Desktop Access
# ----------------
vncserver_configure
firefox_install

# --------------------
# Web/GUI Interfaces
# --------------------
nginx_install
nginx_configure
nginx_customization
php_configure
nginx_fcgiwrap_install
nginx_spawn_fcgi_configure

# ----------
# Databases
# ----------
mysqld_configure

# --------------------------------
# Wireless Access Point (HotSpot)
# --------------------------------
freeradius_install
freeradius_configure
freeradius_attributes_configure
freeradius_test
daloradius_configure
coova_chilli_install
haserl_install
coova_chilli_configure
coova_chilli_customization
coova_chilli_icinga2_dns_monitor
hostapd_install
hostapd_configure

#------------
# Monitoring
# -----------
icinga2_install # Takes a very long time ~ 1 hour
monitoring_plugins_install
check_logfiles_install
icinga2_ido_mysql
icinga2_configure
icingaweb2_install
icingaweb2_configure

# --------
# Content
# --------

# DLNA/UPnP
minidlna_install
minidlna_configure

# VoD Streaming
video_on_demand_configure

# Auto download of TV Shows, Movies, and Podcasts
flexget_deps_install
flexget_install
flexget_configure

# Torrents
xmlrpc_install
libtorrent_install
rtorrent_install
rtorrent_configure
rtgui_configure

# Downloads
aria2_install # Takes ~ 40 mins
aria2_configure

# File server
samba_configure

# ---------------------
# Security Monitoring
# ---------------------
zoneminder_pre_install
zoneminder_install
zoneminder_configure 
zoneminder_zms_inetd

# -----------------
# Utilities/tools
# -----------------
w_scan_install 
youtube_dl_install
cutter_install 
rtmpdump_install
gnokii_install
gammu_install
email_smtp_install
email_smtp_configure
email_via_gmail_setup
gdata_install
google_sms_setup
reverse_ssh_configure

# ----------------
# Communications 
# ----------------
# IM Chat Server (Needed by XMPP usage in Asterisk)
jabberd_configure
jabberd_add_users

# Telephone system support
dahdi_install
libpri_install
asterisk_install
asterisk_configure 

# XMPP
chan_motif_configure

# GSM Trunks/ Mobile Gateways
chan_mobile_configure
chan_dongle_install 
chan_dongle_configure

# Cepstral Support # Not Free!
if [ "$CEPSTRAL_EULA" = "agree" ];
then
cepstral_install 
cepstral_register 
app_swift_install
app_swift_configure
fi

# ASR - Speech Recognition
sphinxbase_install
pocketsphinx_install

# ----------------
# Administration 
# ----------------
# Cloud and Backup support
owncloud_install
owncloud_configure

# ----------------
# Home Automation 
# ----------------
# OpenHAB
#openhab_install
#openhab_configure

# ---------
# Notices
# ---------
# Post install Notes
post_install_notice
#

# ---------
# The End
# ---------
