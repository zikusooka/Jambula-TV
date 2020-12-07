#!/bin/sh
#
# This script will blindly scan for Digital TV frequencies (including
# Free-to-Air) broadcasts in your area
#
# Use it to generate DVB-T/T2 initial data or channels file(s) for
# your favorite Live TV application
#
# Author: Joseph Zikusooka - Twitter: @jzikusooka
#
# Jambula Labs @copyright 2020-2021 All rights reserved

HOME_DIR=$HOME
W_SCAN_CMD=$(which w_scan)
DVB_TYPE=t #(DVB-T/T2)
RAW_CHANNELS_FILE=/tmp/dvbt-raw-channels

DVBv5_FRONTEND_TOOL=/usr/bin/dvb-fe-tool
DVBv5_TUNING_TOOL=/usr/bin/dvbv5-zap
DVBv5_LOCK_OUTPUT_FILE=/tmp/dvbt-signal-lock.tmp
DVBv5_SIGNAL_STRENGTH_FILE=/tmp/dvbt-signal-strength.txt

APP_NUMBER=$1
COUNTRY_CODE=$2
ENCRYPTED=$3



###############
#  FUNCTIONS  #
###############

check_user () {
if [[ "$(whoami)" != "root" ]];
then
clear
echo "ERROR: Incorrect user: You need to run this script as root!
"
exit 1
fi
}

check_if_using_systemd () {
which systemctl > /dev/null 2>&1
USING_SYSTEMD=$?
}

check_if_tvheadend_exists () {
which tvheadend > /dev/null 2>&1
TVHEADEND_EXISTS=$?
}

stop_tvheadend () {
check_if_using_systemd
check_if_tvheadend_exists
#
# Stop tvheadend if it is running
if [[ "$USING_SYSTEMD" = "0" && "$TVHEADEND_EXISTS" = "0" ]];
then
systemctl -q is-active tvheadend.service && systemctl stop tvheadend.service && export RESTART_TVH=Y

elif [[ "$USING_SYSTEMD" != "0" && "$TVHEADEND_EXISTS" = "0" ]];
then
ps auxw | grep tvheadend > /dev/null 2>&1 && killall tvheadend > /dev/null 2>&1
fi
}

usage () {
# Check for w_scan program
if [[ "x$W_SCAN_CMD" = "x" ]];
then
clear
cat <<ET
Please download and install w_scan, an application required for
scanning:

https://www.gen2vdr.de/wirbel/w_scan/w_scan-20170107.tar.bz2

ET
exit 1
fi

# If empty set to default
if [[ "x$APP_NUMBER" = "x" ]];
then
clear
echo "Usage: ./$(basename $0) [Output_Format_used_to_play_TV e.g. 1] [COUNTRY] [Scan encrypted e.g. yes]

1. Xine		- tzap/czap/xine output instead of vdr channels.conf

2. VLC		- generate VLC xspf playlist (experimental)

3. Initial	- generate initial tuning data for (dvb-)scan

4. Mplayer 	- mplayer output instead of vdr channels.conf

5. GStreamer	- generate channels.conf for dvbsrc plugin

6. XML		- generate w_scan XML tuning data

7. VDR (2.1)	- VDR 2.1.x

*. VDR (2.0)	- VDR 2.0.x (Default)
"
exit 1
fi

# Country code - Probably not needed
if [[ "x$COUNTRY_CODE" = "x" ]];
then
COUNTRY_CODE=UG
fi

# Encrypted frequencies
if [[ "x$ENCRYPTED" = "x" ]];
then
ENCRYPTED=yes
fi
}

set_output_format () {
case $APP_NUMBER in
1|'')
# Xine
CHANNELS_FILE_FORMAT=X
APP_CONFIG_DIR=$HOME_DIR/.xine
CHANNELS_FILE=$APP_CONFIG_DIR/channels.conf
;;
2)
# VLC
CHANNELS_FILE_FORMAT=L
APP_CONFIG_DIR=.config/vlc
CHANNELS_FILE=$APP_CONFIG_DIR/channels.xspf
;;
3)
# Initial Tuning Data
CHANNELS_FILE_FORMAT=x
APP_CONFIG_DIR=/usr/share/dvb/dvb-$DVB_TYPE
CHANNELS_FILE=$APP_CONFIG_DIR/auto-$COUNTRY_CODE
;;
4)
# Mplayer
CHANNELS_FILE_FORMAT=M
APP_CONFIG_DIR=$HOME_DIR/.mplayer
CHANNELS_FILE=$APP_CONFIG_DIR/channels.conf
;;
5)
# GStreamer
CHANNELS_FILE_FORMAT=G
APP_CONFIG_DIR=$HOME_DIR/.gstreamer*
CHANNELS_FILE=$APP_CONFIG_DIR/channels.dvbsrc
;;
6)
# XML
CHANNELS_FILE_FORMAT=Z
APP_CONFIG_DIR=$HOME_DIR
CHANNELS_FILE=$APP_CONFIG_DIR/xml-channels.conf
;;
7)
# VDR-2.1.x
CHANNELS_FILE_FORMAT="o 21" 
APP_CONFIG_DIR=$HOME_DIR
CHANNELS_FILE=$APP_CONFIG_DIR/vdr-2.1.x-channels.conf
;;
*)
# VDR-2.0.x
CHANNELS_FILE_FORMAT="o 2" #2= VDR-2.0.x (default) 21=VDR-2.1.x
APP_CONFIG_DIR=$HOME_DIR
CHANNELS_FILE=$APP_CONFIG_DIR/vdr-2.0.x-channels.conf
;;
esac
}

pre_setup () {
# Set file output format
set_output_format
#
# Get the number of dvb cards
DVB_TUNERS_NO=$(ls -x /dev/dvb | wc -l)
#
if [[ "x$DVB_TUNERS_NO" = "x" ]];
then
clear
cat <<ET
Error: Sorry I did not find any DVB devices! Please check your setup 
and ensure TV card/dongle is properly inserted

ET
exit 1

elif [[ "$DVB_TUNERS_NO" = "1" ]];
then
# Get PID of process currently using DVB card
DVB_RUNNING_PID=$(/usr/sbin/lsof -t /dev/dvb/*/*)
#
# Stop tvheadend or kill other process currently using DVB card
stop_tvheadend || $(if [[ "x$DVB_RUNNING_PID" != "x" ]]; then kill $DVB_RUNNING_PID; fi)
# Pause a bit to allow processs like tvheadend to die properly
sleep 3

else
clear
cat <<ET
Hi there, It appears you are using multiple DVB devices.  Please
edit this script ($(basename $0)) and specify which device you want
to use for scanning.  

HINT: Option '-a' for tools used is your friend!

ET
exit 1
fi

# Create App config directory if it does not exist
[[ -d $APP_CONFIG_DIR ]] || mkdir -p $APP_CONFIG_DIR

# Backup existing file
[[ -e $CHANNELS_FILE ]] && mv -v $CHANNELS_FILE $CHANNELS_FILE.$(date +%Y%m%d)
}

scan_4_freqs_no_encrypt () {
$W_SCAN_CMD -v -F -t 3 -C 'UTF-8' -f $DVB_TYPE -c $COUNTRY_CODE -$CHANNELS_FILE_FORMAT -T 1 -R 1 -O 1 -E 0 > $RAW_CHANNELS_FILE
SCAN_FREQ_STATUS=$?
}

scan_4_freqs_w_encrypt () {
$W_SCAN_CMD -v -F -t 3 -C 'UTF-8' -f $DVB_TYPE -c $COUNTRY_CODE -$CHANNELS_FILE_FORMAT -T 1 -R 1 -O 1 -E 1 > $RAW_CHANNELS_FILE
SCAN_FREQ_STATUS=$?
}

get_signal_strength () {
# Add header to signal strength info file
cat > $DVBv5_SIGNAL_STRENGTH_FILE <<ET
Frequency		 Signal			SNR
---------		 ------			---

ET
#
# Parse discovered DVB-T frequencies file
[[ -s $RAW_CHANNELS_FILE ]] && \
	sed "/^#/d" $RAW_CHANNELS_FILE | while read LINE
do

# Get Frequency
FREQUENCY=$(echo $LINE | awk {'print $2'})

cat <<ET
Locking to $FREQUENCY ...
ET

# Tune to Frequency
$DVBv5_TUNING_TOOL -t 1 -C UG -c $CHANNELS_FILE $FREQUENCY > /dev/null 2>&1
$DVBv5_TUNING_TOOL -t 1 -C UG -c $CHANNELS_FILE $FREQUENCY > /dev/null 2>&1
LOCK_STATUS=$?

# Pause a bit
sleep 3

# Skip if we failed to lock to frequency
[[ "$LOCK_STATUS" = "1" ]] || continue

# Capture Signal and SNR values from lock output file
$DVBv5_FRONTEND_TOOL -A -c1 > $DVBv5_LOCK_OUTPUT_FILE 2>&1
#
SIGNAL=$(grep -i Lock $DVBv5_LOCK_OUTPUT_FILE | awk {'print $4'})
SNR=$(grep -i Lock $DVBv5_LOCK_OUTPUT_FILE | awk {'print $6'})

# Add Frequency, plus it's Signal/SNR values to signal strength file
cat >> $DVBv5_SIGNAL_STRENGTH_FILE <<ET
$FREQUENCY		$SIGNAL		$SNR

ET

# Pause a bit
sleep 3

done
}

print_scan_report () {
clear
cat <<ET
===========================================================
DVB-T/2 Scan Report:	$(date +'%A, %d %B %Y %_I:%M %p')
===========================================================
The following DVB-T/2 frequencies are available in your area:

$(cat $DVBv5_SIGNAL_STRENGTH_FILE)

(Encrypted channels included: $(if [[ "$ENCRYPTED" != "yes" ]]; then echo No; else echo Yes; fi))

The channels.conf file was saved and can be found at:
$CHANNELS_FILE
ET
}

print_failed_notice () {
clear
cat <<ET
Error: I failed to get any working frequency/transponder in your area

Please check and ensure that the TV Antenna is properly hooked up to 
the TV tuner before running this tool again

If this error persists, you might want to try using a different type 
of TV tuner
ET
}

post_setup () {
# Start tvheadend if it was running before
[[ "$RESTART_TVH" = "Y" ]] && systemctl start tvheadend.service
}



#################
#  MAIN SCRIPT  #
#################

# Check who is running this script
check_user

# Usage
usage

# Pre setup
pre_setup

# Scan
if [[ "$ENCRYPTED" = "yes" ]];
then
# Don't skip encrypted
scan_4_freqs_w_encrypt

else
# Skip encrypted
scan_4_freqs_no_encrypt
fi

# Convert to DVBV5 format
dvb-format-convert -I CHANNEL -O DVBV5 $RAW_CHANNELS_FILE $CHANNELS_FILE

# Signal strength information
get_signal_strength
#
if [[ ! -s $RAW_CHANNELS_FILE ]] || [[ "$SCAN_FREQ_STATUS" = "1" ]];
then
# Print failed notice
print_failed_notice

else
# Print frequencies discovered and the location of channels data file
print_scan_report
fi

# Post setup
post_setup
