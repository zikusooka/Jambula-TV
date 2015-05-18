#!/bin/sh
clear

INSERTED_DONGLE=`cat /var/log/messages | grep Adapter | grep -i "has been enabled" | tail -n 1 | cut -d "/" -f5 | sed -e "s/ has been enabled//"`

# Set hci device
if [ "x$INSERTED_DONGLE" = "x" ]
then
DEV=hci0
else
DEV=$INSERTED_DONGLE
fi

CHIPSET=`hciconfig -a hci$DEV_NO |grep Manufacturer | cut -d ":" -f2 | cut -d "(" -f1 | sed -e 's/ //'`

VERSION=`hciconfig $DEV revision |grep Chip | sed -e 's/Chip version: //' | awk {'print $1'}`


echo "This dongle has the following chipset:

$CHIPSET
$VERSION

"

if [ "$VERSION" = "BlueCore4-ROM" ];
then 
echo "It will work with chan Mobile and You can easily change the MAC Address for use
on multiple devices
"
else
echo "You will not be able to use it for multiple chan mobile trunks
"
fi

