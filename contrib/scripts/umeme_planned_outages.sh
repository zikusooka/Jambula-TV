#!/bin/sh
#
# Prerequisites:
# Install catdoc i.e. yum install catdoc

# Future enhancements
# 1. Send Telegram Notices

DATE_AFTER_TOMORROW_UMEME_FORMAT=$(date --date='2 day' +'%A,%d')
DATE_TOMORROW_UMEME_FORMAT=$(date --date='1 day' +'%A,%d')
DATE_TODAY_UMEME_FORMAT=$(date +'%A,%d')

DATE_AFTER_TOMORROW_DAY_FORMAT=$(date --date='2 day' +'%A')
DATE_TOMORROW_DAY_FORMAT=$(date --date='1 day' +'%A')

TERM=xterm
OSD_CMD="/usr/bin/jambulatv-osd"
OSD_CMD_OPTS="-m"

THIS_MONTH=$(date +%b)

UMEME_ROOT_URL=http://www.umeme.co.ug
UMEME_OUTAGES_URL=$(curl -s $UMEME_ROOT_URL/search.html?id=7 -d search=Planned%20Outages | grep extract | grep '.xls' | sort -u | sed 's:<[^>]\+>::g' | sed 's:^ *::g' | grep -i "$THIS_MONTH" | sed 's: :%20:g')

UMEME_PLANNED_OUTAGE_FILE="$(basename $UMEME_OUTAGES_URL)"

UMEME_EXCEL_FILE=/tmp/UMEME_Planned.${THIS_MONTH}.xls
UMEME_MONTHLY_FILE=/JambulaTV/Downloads/UMEME_Planned.${THIS_MONTH}.csv

TELEGRAM_CREDENTIALS_CONFIG=/etc/JambulaTV/messaging-telegram.cfg

PING_COUNT=1 #9
PING_IP_ADDRESS=8.8.8.8

LIST_OF_AREAS="$@"



###############
#  FUNCTIONS  #
###############

send_telegram () {
. $TELEGRAM_CREDENTIALS_CONFIG
# SendMesage
$TELEGRAM_SCRIPT SendMessage "$@" &
}

usage () {
if [ "x$LIST_OF_AREAS" = "x" ];
then
clear
echo "Usage: $(basename $0) [LIST_OF AREAS (Seperate with space e.g. Ntinda Kiwatule)]"
exit
fi
}

check_internet_access () {
# Check for internet connectivity - IMPORTANT: Don't use DNS to ping use actual IP address
ping -c $PING_COUNT $PING_IP_ADDRESS > /dev/null 2>&1
EXITVAL=$?
if [ "$EXITVAL" != "0" ];
then
# Quit script, since there's no internet.  Leave exit status at 0 so systemd service works
echo "JambulaTV Error: There's no Internet.  Please connect first!"
exit 0
fi
}



#################
#  MAIN SCRIPT  #
#################

usage

# Check if Internet connection is up
check_internet_access
INTERNET_ALIVE=$EXITVAL

# Download UMEME file for this month if Internet is up
if [ "$INTERNET_ALIVE" = "0" ];
then
# pick latest from Internet
echo "Downloading UMEME Planned outages file [$UMEME_PLANNED_OUTAGE_FILE] for this month ..."
wget -c -O $UMEME_EXCEL_FILE $UMEME_OUTAGES_URL

	if [ "$?" != "0" ];
	then
	echo "Error: Failed to download the file [$UMEME_PLANNED_OUTAGE_FILE]"
	echo
	exit 1
	fi
# Covert xls to csv
xls2csv -x $UMEME_EXCEL_FILE -s cp1252 -d 8859-1 | sed "s:\"::g"> $UMEME_MONTHLY_FILE
#
elif [ ! -e "$UMEME_MONTHLY_FILE" ] && [ "$INTERNET_ALIVE" != "0" ];
then
# No file, and no Internet, so quit
echo "The file $UMEME_MONTHLY_FILE is missing.  Please download it at:

$UMEME_ROOT_URL
"
exit
fi


# Check for selected areas
for VILLAGE in $LIST_OF_AREAS
do

# Two days from now
# -----------------
# OSD
grep -i $DATE_AFTER_TOMORROW_UMEME_FORMAT $UMEME_MONTHLY_FILE | grep -i "$VILLAGE" > /dev/null 2>&1 && \
   $OSD_CMD $OSD_CMD_OPTS "UMEME planned outage: There will be no power in $VILLAGE on $DATE_AFTER_TOMORROW_DAY_FORMAT"

# Telegram
grep -i $DATE_AFTER_TOMORROW_UMEME_FORMAT $UMEME_MONTHLY_FILE | grep -i "$VILLAGE" > /dev/null 2>&1 && \
	send_telegram "UMEME planned outage: There will be no power in $VILLAGE on $DATE_AFTER_TOMORROW_DAY_FORMAT"

# Tomorrow
# ---------
# OSD
grep -i $DATE_TOMORROW_UMEME_FORMAT $UMEME_MONTHLY_FILE | grep -i "$VILLAGE" > /dev/null 2>&1 && \
   $OSD_CMD $OSD_CMD_OPTS "UMEME planned outage: There will be no power in $VILLAGE on $DATE_TOMORROW_DAY_FORMAT"

# Telegram
grep -i $DATE_TOMORROW_UMEME_FORMAT $UMEME_MONTHLY_FILE | grep -i "$VILLAGE" > /dev/null 2>&1 && \
	send_telegram "UMEME planned outage: There will be no power in $VILLAGE on $DATE_TOMORROW_DAY_FORMAT"

# Today before 9am
# ----------------
# OSD
if [ "$(date +%H)" -lt "12" ];
then
grep -i $DATE_TODAY_UMEME_FORMAT $UMEME_MONTHLY_FILE | grep -i "$VILLAGE" > /dev/null 2>&1 && \
   $OSD_CMD $OSD_CMD_OPTS "UMEME planned outage: There will be no power in $VILLAGE Today"

# Telegram
grep -i $DATE_TODAY_UMEME_FORMAT $UMEME_MONTHLY_FILE | grep -i "$VILLAGE" > /dev/null 2>&1 && \
	send_telegram "UMEME planned outage: There will be no power in $VILLAGE Today"
fi

done
