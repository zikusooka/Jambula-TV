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

THIS_MONTH=$(date +%B)

UMEME_ROOT_URL=http://www.umeme.co.ug
UMEME_OUTAGES_URL=$(curl -s $UMEME_ROOT_URL/search.html?id=7 -d search=Planned%20Outages | grep extract | grep '.xls' | sort -u | sed 's:<[^>]\+>::g' | sed 's:^ *::g' | grep -i "$THIS_MONTH" | sed 's: :%20:g')

UMEME_PLANNED_OUTAGE_FILE="$(basename $UMEME_OUTAGES_URL)"

UMEME_EXCEL_FILE=/tmp/UMEME_Planned.${THIS_MONTH}.xls
UMEME_MONTHLY_FILE=/JambulaTV/Downloads/UMEME_Planned.${THIS_MONTH}.csv

LIST_OF_AREAS="$@"

if [ "x$LIST_OF_AREAS" = "x" ];
then
clear
echo "Usage: $(basename $0) [LIST_OF AREAS (Seperate with space e.g. Ntinda Kiwatule)]"
exit
fi


# Check if Internet connection is up
host -W 1 google.com 8.8.8.8 > /dev/null 2>&1
INTERNET_ALIVE=$?

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
grep -i $DATE_AFTER_TOMORROW_UMEME_FORMAT $UMEME_MONTHLY_FILE | grep -i "$VILLAGE" > /dev/null 2>&1 && \
   $OSD_CMD $OSD_CMD_OPTS "UMEME planned outage: There will be no power in $VILLAGE on $DATE_AFTER_TOMORROW_DAY_FORMAT"

# Tomorrow
grep -i $DATE_TOMORROW_UMEME_FORMAT $UMEME_MONTHLY_FILE | grep -i "$VILLAGE" > /dev/null 2>&1 && \
   $OSD_CMD $OSD_CMD_OPTS "UMEME planned outage: There will be no power in $VILLAGE on $DATE_TOMORROW_DAY_FORMAT"

# Today before 9am
if [ "$(date +%H)" -lt "12" ];
then
grep -i $DATE_TODAY_UMEME_FORMAT $UMEME_MONTHLY_FILE | grep -i "$VILLAGE" > /dev/null 2>&1 && \
   $OSD_CMD $OSD_CMD_OPTS "UMEME planned outage: There will be no power in $VILLAGE Today"
fi

done
