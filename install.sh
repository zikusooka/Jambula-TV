#!/bin/sh

# Source functions file
. /JambulaTV/RELEASE-2.0/functions



#################
#  MAIN SCRIPT  #
#################

# Create installation directory
install_dir_create

# pick desired X11 video driver
#cat <<EOF > /dev/null 
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
#EOF
#
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
SDL1_install
openal_soft_install
ffmpeg_deps_install
live555_install
libdvbpsi_install 
#
# Install ffmpeg first without x264 - will be removed and re-installed shortly
ffmpeg_install && x264_install 
# Uninstall already existing ffmpeg (without x264 libs) and install agian w/ x264
uninstall_src_pkgs ffmpeg && ffmpeg_install
#
vlc_install
xine_lib_install
xine_ui_install
mplayer_install
sox_install
v4l_utils_install
tvheadend_install
tvheadend_configure
fmtools_install
libusb_install
xbmc_deps_install
xbmc_install
xbmc_addons_pvr_install
xbmc_addons_all_install
python_xbmc_install
xbmc_configure
xbmc_customization 

# kodi
# ----
#kodi_install

lircd_configure
x11_configure
autologin_lxde
plymouth_customization
grub_settings 
autologin_user_configure
autostart_xbmc_service
tv_cards_configure
tv_pulse_audio_configure 

# System Settings
boot_optimization
network_configure
openssl_configure
wol_configure 

# Desktop
vncserver_configure
firefox_install

# Web/GUI Interfaces
nginx_install
nginx_configure
nginx_customization
php_configure
nginx_fcgiwrap_install
nginx_spawn_fcgi_configure

# HotSpot settings
freeradius_install
freeradius_configure
freeradius_attributes_configure
freeradius_test
daloradius_configure
coova_chilli_install
haserl_install
coova_chilli_configure
coova_chilli_customization
hostapd_install
hostapd_configure
# Run these before icinga configure
chrony_configure
dnsmasq_configure
openresolv_install
openresolv_configure

# Proxy server support
ziproxy_install
ziproxy_configure

# WAN Accelerator support
squid_install
squid_configure # configured for use by ziproxy WAN accelerator
ziproxy_wan_accel_configure

# Monitoring software
icinga2_install # Takes a very long time ~ 1 hour
monitoring_plugins_install
icinga2_ido_mysql
icinga2_configure
icingaweb2_install

# CCTV Support
zoneminder_pre_install
zoneminder_install 
zoneminder_configure 

# Internet Access 
# Dual virtual interfaces
virtual_wifi_interfaces_configure
# Wifi (mifi)
internet_mifi_configure 
# USB (3G) 
internet_usb_3g_configure

# FlexGet
flexget_deps_install
flexget_install
flexget_configure

# Torrents
rtorrent_install
rtorrent_configure
rtgui_configure

# Aria2
aria2_install
aria2_configure


# Alert sounds
beep_spkr_configure
#beep2_install # No longer needed

# DLNA/UPnP
# ---------
# xupnp: Supports playlists, live TV
xupnpd_install
xupnpd_configure

# minidlna: No support for playlists
#minidlna_install
#minidlna_configure

# VoD Streaming
video_tv_on_demand_configure 
#tv_on_demand_configure 

# Reminders - Birthdays, Anniversaries, Holidays, etc
remind_configure 

# Email - Phone home support
email_smtp_install
email_smtp_configure


# Utilities/tools
# ---------------
# DVB-T/S
w_scan_install 
# Youtube-dl
youtube_dl_install
# Cut TCP/IP connections via gateway
cutter_install 
# IPTV
rtmpdump_install
# GSM Phone Access
gnokii_install
gammu_install


# Google SMS Support
gdata_install
google_sms_setup
 
# Remote Access
reverse_ssh_configure

# VPN Support
openvpn_configure 

# IM Chat Server (Needed by XMPP useage in Asterisk)
jabberd_configure
jabberd_add_users 


# Telephone system support
dahdi_install
libpri_install
asterisk_install
asterisk_configure 

chan_mobile_configure

chan_dongle_install 
chan_dongle_configure

chan_motif_configure

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

# UniMRCP
#unimrcp_deps_install 
#unimrcp_install
#asterisk_unimrcp_install

# Cloud and Backup support
owncloud_install


# Post install Notes
post_install_notice

# END #
#######
