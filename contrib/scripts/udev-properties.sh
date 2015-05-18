#!/bin/sh
# This script queries all the udev associated properties for an inserted  USB device 
#
# Copyright (C) 2015-2016 Joseph Zikusooka.
#
# Contact me at: joseph AT zikusooka.com

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.



clear
DEVICE_NODE=$1

# Quit if no arguments are listed
if [ "x$DEVICE_NODE" = "x" ];
then
echo "Usage: `basename $0` [Device node e.g. /dev/video1]
"
exit 1
fi
#

udevadm info -a -p `udevadm info -q path -n $DEVICE_NODE`
