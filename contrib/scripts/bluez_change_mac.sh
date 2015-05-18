#!/bin/sh
# This script will write new MAC Ids into the firmware of the USB dongle.
# Works with S-Tek dongles

srcdir=/usr/src/jambulatv

BD_ADDR_CMD=/usr/sbin/bluez_bdaddr






# Create simple-agent command if it does NOT exit
if [ ! -e $BD_ADDR_CMD ];
then
# Copy bdaddr script from Bluez sources to executable PATH
cp -f $srcdir/bluez/test/bdaddr $BD_ADDR_CMD
#
fi


# Change mac address
$BD_ADDR_CMD  -i hci0 -r 00:11:67:55:8F:72
$BD_ADDR_CMD  -i hci1 -r 00:11:67:55:8F:73

