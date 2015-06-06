#!/bin/sh

ACCOUNT_PHONE_NUMBER=$1
ACCOUNT_ACCESS_CODE=$2
ACCOUNT_BALANCE_URL="http://orange.ug/iewselfhelp/index.php"
ACCOUNT_BALANCE_OUTPUT=/tmp/orange_balance.html






# Check for correct command usage/arguments
command_usage () {
echo "Usage:  ./`basename $0` [PHONE NUMBER] [ACCESS CODE]
Example:./`basename $0` 0790808663 44759"
}
#
if [ "x$1" = "x" ];
then
command_usage
exit 1
elif [ "x$2" = "x" ];
then
command_usage
exit 1
fi









# Remove prevous balance file
[ ! -e $ACCOUNT_BALANCE_OUTPUT ] || rm -f $ACCOUNT_BALANCE_OUTPUT

# Query balance URL site
/usr/bin/curl -bj -L -sS -m 60 -A 'Mozilla/5.0' -o $ACCOUNT_BALANCE_OUTPUT -d number=$ACCOUNT_PHONE_NUMBER -d access_code=$ACCOUNT_ACCESS_CODE -d getusage=get%20usage $ACCOUNT_BALANCE_URL 

# Grep file for days and bandwidth left
DAYS_LEFT=`grep -i 'time left' $ACCOUNT_BALANCE_OUTPUT | sed -e 's/<[^>]*>//g' | cut -d ':' -f2 | awk {'print $1'}`
BANDWIDTH_LEFT=`grep -i 'volume left' $ACCOUNT_BALANCE_OUTPUT | sed -e 's/<[^>]*>//g' | cut -d ':' -f2 | awk {'print $1$2'}`

# Export query results
export BANDWIDTH_LEFT DAYS_LEFT


# Added for Orange-Pi
# -------------------
EMAIL_TO_ADDRESS_REMOTE=joseph@aexcomputers.com
EMAIL_SUBJECT="Internet bandwidth and days remaining"

# Static variables
MACHINE_HOST=`hostname -s`

EMAIL_CMD=/usr/bin/email
EMAIL_OPTIONS="-V --tls"
EMAIL_FROM_FULLNAME="$MACHINE_HOST"
EMAIL_FROM_ADDRESS="${MACHINE_HOST}@`hostname -d`"

EMAIL_SMTP_SERVER_NAME=smtp.gmail.com
EMAIL_SMTP_SERVER_PORT=587
EMAIL_SMTP_AUTH_USERNAME="smtprelayug@gmail.com"
EMAIL_SMTP_AUTH_ENCRYPT="MjU2c210cHJlbGF5dWcK"
EMAIL_SMTP_AUTH_PASSWORD=`echo $EMAIL_SMTP_AUTH_ENCRYPT | base64 -d`


BANDWIDTH_LEFT_THRESHOLD=9
DAYS_LEFT_THRESHOLD=30
BANDWIDTH_LEFT_DIGITS=`echo "$BANDWIDTH_LEFT" | sed -e "s/[G|M|B]//g" | cut -d . -f1`
EMAIL_SENT_FILE=/tmp/email_sent_`date +%Y%m%d`



# Quit if notification was already sent today
[ ! -e $EMAIL_SENT_FILE ] || exit 0

# Notify client if balance is running low or expiry days are near
if [ "$BANDWIDTH_LEFT_DIGITS" -le "$BANDWIDTH_LEFT_THRESHOLD" ] || [ "$DAYS_LEFT" -le "$DAYS_LEFT_THRESHOLD" ];
then
# send email
#-------------
$EMAIL_CMD $EMAIL_OPTIONS \
  -s "$EMAIL_SUBJECT" -n $EMAIL_FROM_FULLNAME -f $EMAIL_FROM_ADDRESS \
  -r $EMAIL_SMTP_SERVER_NAME -p $EMAIL_SMTP_SERVER_PORT -m LOGIN \
  -u $EMAIL_SMTP_AUTH_USERNAME -i $EMAIL_SMTP_AUTH_PASSWORD \
   $EMAIL_TO_ADDRESS_REMOTE <<EOF
Hi there!

The current bandwdith cap for your Orange Internet account ($ACCOUNT_PHONE_NUMBER) is:

		---------------------------------------------
		Bandwidth Data as of `date +'%b %d at %I:%M:%S'`
		---------------------------------------------
		Data Bandwidth Left		=	$BANDWIDTH_LEFT
		Bandwidth Days Left 		=  	$DAYS_LEFT



---------
This message was sent using the Orange-Pi, a product of:                                     
 ▗▄         ▐       ▝▜          ▗       ▐       
  ▐  ▄▖ ▗▄▄ ▐▄▖ ▗ ▗  ▐   ▄▖     ▐    ▄▖ ▐▄▖  ▄▖ 
  ▐ ▝ ▐ ▐▐▐ ▐▘▜ ▐ ▐  ▐  ▝ ▐     ▐   ▝ ▐ ▐▘▜ ▐ ▝ 
  ▐ ▗▀▜ ▐▐▐ ▐ ▐ ▐ ▐  ▐  ▗▀▜     ▐   ▗▀▜ ▐ ▐  ▀▚ 
▝▄▞ ▝▄▜ ▐▐▐ ▐▙▛ ▝▄▜  ▝▄ ▝▄▜     ▐▄▄▖▝▄▜ ▐▙▛ ▝▄▞ 
                                                                                                                
EOF
echo "`date`" > $EMAIL_SENT_FILE
fi
