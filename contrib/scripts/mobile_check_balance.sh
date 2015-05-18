#!/bin/sh

CREDIT_BALANCE_MINIMUM=1000
WAIT_TIME=5  # In seconds, Wait for provider
ASTERISK_CONNECT_CMD="asterisk -rx" 
ASTERISK_LOG_FILE=/var/log/asterisk/messages
MOBILE_PHONE_GROUP=$@
MOBILE_PHONE_STATUS=Free
BALANCE_CODE="*131#"


# Usage: Help if no arguments are passed on command line
if [ "x$MOBILE_PHONE_GROUP" = "x" ];
then
clear
echo "Usage: `basename $0` [Chan_Mobile Group]
"
exit
fi

# Available mobile device trunk
MOBILE_DEVICE=$($ASTERISK_CONNECT_CMD 'mobile show devices' | awk '$3 == '$MOBILE_PHONE_GROUP'' | grep $MOBILE_PHONE_STATUS | awk {'print $1'} | head -1 | sed 's: ::g')



#################
#  MAIN SCRIPT  #
#################

# Check for Balance on specified network & sleep for a few seconds to allow provider 2 reply
$ASTERISK_CONNECT_CMD "mobile cusd $MOBILE_DEVICE $BALANCE_CODE" && sleep $WAIT_TIME

CREDIT_BALANCE=`grep "chan_mobile.c: \[$MOBILE_DEVICE\] CUSD response" $ASTERISK_LOG_FILE | tail -n 1 | awk {'print $13'} | cut -d "." -f1`


# Notfy if running low
clear
if [ "$CREDIT_BALANCE" -lt $CREDIT_BALANCE_MINIMUM ];
then
echo "The credit balance (Ushs. $CREDIT_BALANCE) on your phone device [$MOBILE_DEVICE] is LOW! 
Please re-charge as soon as possible
"
else
echo "The credit balance on your phone device [$MOBILE_DEVICE] is: Ushs. $CREDIT_BALANCE
"
fi
