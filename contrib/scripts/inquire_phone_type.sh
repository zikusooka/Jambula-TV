#!/bin/sh
# To Inquire whether a phone is of FXO (Phone) or FXS (Headset) type
#####################################################################

HCITOOL_CMD=/usr/bin/hcitool

clear

echo "
Please ensure Phone has been put in 'Browseable Mode'. Enter to continue
"
read BOGUS

$HCITOOL_CMD inq
