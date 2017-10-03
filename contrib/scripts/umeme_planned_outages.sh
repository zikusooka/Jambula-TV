#!/bin/sh
#
# Prerequisites:
# Install catdoc i.e. yum install catdoc
# Install poppler-utils i.e. yum install poppler-utils
#
DATE_AFTER_TOMORROW_DAY_FORMAT=$(date --date='2 day' +'%A')
DATE_TOMORROW_DAY_FORMAT=$(date --date='1 day' +'%A')

THIS_YEAR=$(date +%Y)
THIS_MONTH_NAME_FULL=$(date +%B)
THIS_MONTH_DIGIT=$(date +%m)

DATE_DIGIT_AFTER_TOMORROW=$(date --date='2 day' +'%d')
DATE_DIGIT_TOMORROW=$(date --date='1 day' +'%d')
DATE_DIGIT_TODAY=$(date +'%d')

CURL_CMD="/usr/bin/curl"
CURL_OPTS="-s -S -L"

USER_AGENT="Mozilla/5.0 (X11; Linux x86_64; rv:54.0) Gecko/20100101 Firefox/54.0"

TERM=xterm
OSD_CMD="/usr/bin/jambulatv-osd"
OSD_CMD_OPTS="-m"

UMEME_HOME_WEB_PAGE="http://www.umeme.co.ug"
UMEME_OUTAGES_WEB_PAGE=$UMEME_HOME_WEB_PAGE/current-outages
UMEME_OUTAGES_OUTPUT=/tmp/umeme-outages.html
UMEME_OUTAGES_FILE_FORMAT=pdf
# UMEME variables based on input file
case $UMEME_OUTAGES_FILE_FORMAT in
pdf)
DATE_AFTER_TOMORROW_UMEME_FORMAT=$(date --date='2 day' +'%d %B')
DATE_TOMORROW_UMEME_FORMAT=$(date --date='1 day' +'%d %B')
DATE_TODAY_UMEME_FORMAT=$(date +'%d %B')
UMEME_OUTAGES_PLANNED_FILE=/JambulaTV/Downloads/UMEME-planned-outages-${THIS_YEAR}-${THIS_MONTH_DIGIT}.pdf
;;
xls)
DATE_AFTER_TOMORROW_UMEME_FORMAT=$(date --date='2 day' +'%A,%d')
DATE_TOMORROW_UMEME_FORMAT=$(date --date='1 day' +'%A,%d')
DATE_TODAY_UMEME_FORMAT=$(date +'%A,%d')
UMEME_OUTAGES_PLANNED_FILE=/JambulaTV/Downloads/UMEME-planned-outages-${THIS_YEAR}-${THIS_MONTH_DIGIT}.xls
;;
esac
# Our output file
UMEME_OUTAGES_PLANNED_FILE_CSV=/JambulaTV/Downloads/UMEME-planned-outages-${THIS_YEAR}-${THIS_MONTH_DIGIT}.csv

TELEGRAM_CREDENTIALS_CONFIG=/etc/JambulaTV/messaging-telegram.cfg

PING_COUNT=1 #9
PING_IP_ADDRESS=8.8.8.8

LIST_OF_AREAS="$@"



###############
#  FUNCTIONS  #
###############

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
INTERNET_ALIVE=$?
}

send_telegram () {
. $TELEGRAM_CREDENTIALS_CONFIG
# SendMesage
$TELEGRAM_SCRIPT SendMessage "$@" &
}

send_notifications () {
# Set day text string
if [ "$1" != "Today" ];
then
DAY_TEXT="on $1"
else
DAY_TEXT="$1"
fi
#
echo "UMEME planned outage: There will be no power in $VILLAGE $DAY_TEXT"
$OSD_CMD $OSD_CMD_OPTS "UMEME planned outage: There will be no power in $VILLAGE $DAY_TEXT"
send_telegram "UMEME planned outage: There will be no power in $VILLAGE $DAY_TEXT"
}

download_outages_webpage () {
# Download latest outages web page from UMEME website
echo "Downloading UMEME outages web page:  $UMEME_OUTAGES_WEB_PAGE ..."
$CURL_CMD $CURL_OPTS -A "$USER_AGENT" -o $UMEME_OUTAGES_OUTPUT $UMEME_OUTAGES_WEB_PAGE
}

extract_outages_file_link () {
# Extract outages link if any
UMEME_OUTAGES_URL=$(sed -n 's/.*href="\([^"]*\).*/\1/p' $UMEME_OUTAGES_OUTPUT | grep -i -e $THIS_MONTH_NAME_FULL -e shutdown)
}

download_outages_file_if_found () {
# Quit if no links related to planned outages were found
if [ "x$UMEME_OUTAGES_URL" = "x" ];
then
clear
cat <<EOF
Error: Am sorry I did not find any UMEME link to ${THIS_MONTH_NAME_FULL}'s planned power outages. 
Please visit $UMEME_OUTAGES_WEB_PAGE to find out why its missing.
EOF
exit 1
#
else
# Fetch planned outages file
echo "Downloading UMEME Planned outages file for ${THIS_MONTH_NAME_FULL}:  $UMEME_OUTAGES_URL ..."
wget -c -O $UMEME_OUTAGES_PLANNED_FILE $UMEME_OUTAGES_URL
fi
}

get_outages_file () {
# Download fresh UMEME file for this month if Internet is up
if [ "$INTERNET_ALIVE" = "0" ];
then
download_outages_webpage
extract_outages_file_link
download_outages_file_if_found
elif [[ ! -e "$UMEME_OUTAGES_PLANNED_FILE" && "$INTERNET_ALIVE" != "0" ]];
then
# No file, and no Internet, so quit
clear
echo "The file $UMEME_OUTAGES_PLANNED_FILE is missing. Please download it at:

$UMEME_OUTAGES_WEB_PAGE
"
exit 1
fi
}

prepare_outages_file () {
# Covert xls to csv
[ "$UMEME_OUTAGES_FILE_FORMAT" = "xls" ] && \
	xls2csv -x $UMEME_OUTAGES_PLANNED_FILE -s cp1252 -d 8859-1 | sed "s:\"::g"> $UMEME_OUTAGES_PLANNED_FILE_CSV

# Convert PDF to txt
[ "$UMEME_OUTAGES_FILE_FORMAT" = "pdf" ] && \
	pdftotext -layout $UMEME_OUTAGES_PLANNED_FILE $UMEME_OUTAGES_PLANNED_FILE_CSV
}

outage_in_two_days_time () {
# Set outage coming flag if date is found in outages file
case "$UMEME_OUTAGES_FILE_FORMAT" in
pdf)
grep -i -A4 $VILLAGE $UMEME_OUTAGES_PLANNED_FILE_CSV  | grep -i ${THIS_MONTH_NAME_FULL} | grep $DATE_DIGIT_AFTER_TOMORROW > /dev/null 2>&1
OUTAGE_COMING_TWO_DAYS=$?
;;
xls)
grep -i $DATE_AFTER_TOMORROW_UMEME_FORMAT $UMEME_OUTAGES_PLANNED_FILE_CSV | grep -i "$VILLAGE" > /dev/null 2>&1
OUTAGE_COMING_TWO_DAYS=$?
;;
esac
#
# Notify of upcoming outage
if [ "$OUTAGE_COMING_TWO_DAYS" = "0" ];
then
send_notifications $DATE_AFTER_TOMORROW_DAY_FORMAT
fi
}

outage_tomorrow () {
# Set outage coming flag if date is found in outages file
case "$UMEME_OUTAGES_FILE_FORMAT" in
pdf)
grep -i -A4 $VILLAGE $UMEME_OUTAGES_PLANNED_FILE_CSV  | grep -i ${THIS_MONTH_NAME_FULL} | grep $DATE_DIGIT_TOMORROW > /dev/null 2>&1
OUTAGE_COMING_TOMORROW=$?
;;
xls)
grep -i $DATE_TOMORROW_UMEME_FORMAT $UMEME_MONTHLY_FILE | grep -i "$VILLAGE" > /dev/null 2>&1
OUTAGE_COMING_TOMORROW=$?
;;
esac
#
# Notify of upcoming outage
if [ "$OUTAGE_COMING_TOMORROW" = "0" ];
then
send_notifications $DATE_TOMORROW_DAY_FORMAT
fi
}

outage_today () {
# Set outage coming flag if date is found in outages file
case "$UMEME_OUTAGES_FILE_FORMAT" in
pdf)

grep -i -A4 $VILLAGE $UMEME_OUTAGES_PLANNED_FILE_CSV  | grep -i ${THIS_MONTH_NAME_FULL} | grep $DATE_DIGIT_TODAY > /dev/null 2>&1
OUTAGE_COMING_TODAY=$?
;;
xls)
grep -i $DATE_TODAY_UMEME_FORMAT $UMEME_OUTAGES_PLANNED_FILE_CSV | grep -i "$VILLAGE" > /dev/null 2>&1
OUTAGE_COMING_TODAY=$?
;;
esac
#
# Notify of upcoming outage
if [ "$OUTAGE_COMING_TODAY" = "0" ];
then
send_notifications Today
fi
}



#################
#  MAIN SCRIPT  #
#################
# Usage
usage

# Check if Internet connection is up
check_internet_access

# Get and prepare outages file
get_outages_file
prepare_outages_file

# Check for selected areas
for VILLAGE in $LIST_OF_AREAS
do

# Today before 9am
# ----------------
# OSD
[[ "$(date +%H)" -lt "14" ]] && outage_today

# Tomorrow
# ---------
outage_tomorrow

# Two days from now
# -----------------
outage_in_two_days_time

done
