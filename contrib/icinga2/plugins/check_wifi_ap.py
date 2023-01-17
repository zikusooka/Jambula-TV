#!/usr/local/bin/python3
# This script is used by icinga2 to discover WiFi Access 
# Points with in the vicinity
#
# NOTE: You need to have your icinga2 environment properly 
# setup
#
# The heavy lifting i.e. scanning is done by the CLI based
# tool named 'iw'
#  
# Feel free to contact me at: josephzik AT gmail.com
#
# Joseph Zikusooka @copyright 2023-2024 All rights reserved
#

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

import argparse
import subprocess
import sys
import re


wifi_scan_output_file = '/tmp/wifi_ap_scan_results'

OK       = 0
WARNING  = 1
CRITICAL = 2
UNKNOWN  = 3


def get_args():
   """
   Supports the command-line arguments listed below.
   """
   parser = argparse.ArgumentParser(description="WiFi AP Scanner")
   parser._optionals.title = "Options"
   parser.add_argument('-i', '--interface', required=True, help='WiFi interface e.g. wlan0', dest='interface', type=str)
   parser.add_argument('-s', '--ssid', required=True, help='WiFi SSID e.g. JAMBULA', dest='ssid', type=str)
   args = parser.parse_args()
   return args


def interface_setup ():
   """
   Set WiFi interface to UP
   """
   args            = get_args()
   interface       = args.interface

   command_interface_up = ['/usr/bin/sudo', '/usr/sbin/ip', 'link', 'set', interface, 'up']
   subprocess.check_call(command_interface_up)


def wifi_ap_scan():
   """
   Scan for WiFi AP
   """
   args	                = get_args()
   interface            = args.interface
   ssid                 = args.ssid
   command_scan_wifi_ap = [ 'sudo', '/usr/sbin/iw', 'dev', interface, 'scan' ]

   # Scan and write output to temp file
   with open (wifi_scan_output_file, 'w') as output_file:
       subprocess.call(command_scan_wifi_ap, stdout=output_file)

   # Search for SSID match in temp file
   with open (wifi_scan_output_file) as input_file:
       ap_search_result = ''
       for line in input_file:
           line = line.strip()
           m = re.match(r"^SSID: %s$" % ssid, line, re.IGNORECASE)

           if m:
               match = m.group()
               ap_search_result = 'found'
               break
           else:
               ap_search_result = 'not_found'

   return ssid, ap_search_result


if __name__ == "__main__":

  interface_setup ()
  ssid, ap_search_result = wifi_ap_scan ()
 
  if ap_search_result == 'found':
      print (f"Status of [{ssid}] is: Available")
      sys.exit(OK)

  elif ap_search_result == 'not_found':
      print (f"Status of [{ssid}] is: Not Available")
      sys.exit(CRITICAL)

  else:
      print (f"Status of [{ssid}] is: Unknown")
      sys.exit(UNKNOWN)        
