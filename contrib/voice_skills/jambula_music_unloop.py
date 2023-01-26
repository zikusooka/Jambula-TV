#!/usr/local/bin/python3
"""
Jambula Smart Home Speech-to-Text skill
---------------------------------------
Task: Turn off repeat mode for currently playing song i.e. unloop music
Phrase: TURN OFF MUSIC LOOP
Compatibility: System, Home-Assistant
"""

from jambula_common import *
import subprocess

__author__ = 'Joseph Zikusooka'
__copyright__ = 'Jambula Labs @copyright 2023-2024 All rights reserved'
__license__ = 'GPLv3'
__version__ = "0.1.0"


phrase = 'TURN OFF MUSIC LOOP'

def skill ():
    subprocess.run ([MPD_CLIENT_CMD, MPD_CLIENT_OPTS, '-h', MPD_SERVER_IP, '-p', MPD_SERVER_PORT, 'repeat', 'off'])


if __name__ == '__main__':
    skill ()
