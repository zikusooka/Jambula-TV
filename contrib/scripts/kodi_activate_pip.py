#!/usr/bin/env python
# Call Picture-in-Picture (PIP) Bash Script

__author__ = 'JambulaTV'

import subprocess
import sys
import argparse

# Variables
ACTION = str(sys.argv[1])


# Help
parser = argparse.ArgumentParser(description='Call Picture-in-Picture (PIP) Script')
parser.add_argument('toggle-switch', nargs='*', help='Turn PIP either ON or OFF', type=str)
parser.add_argument('change-channels', nargs='*', help='Change PIP to Next TV Channel', type=str)
args = parser.parse_args()

# Script
subprocess.check_call(['/usr/bin/sudo', '/usr/bin/jambulatv-pip', ACTION])
