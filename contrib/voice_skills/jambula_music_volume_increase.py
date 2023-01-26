#!/usr/local/bin/python3
"""
Jambula Smart Home Speech-to-Text skill
---------------------------------------
Task: Increase the volume of currently playing music song
Phrase: INCREASE VOLUME
Compatibility: System, Home-Assistant
"""

from jambula_common import *
import subprocess

__author__ = 'Joseph Zikusooka'
__copyright__ = 'Jambula Labs @copyright 2023-2024 All rights reserved'
__license__ = 'GPLv3'
__version__ = "0.1.0"


phrase = 'INCREASE VOLUME'

def skill ():
    VOLUME_STEP = '10'
    subprocess.run ([MPD_CLIENT_CMD, MPD_CLIENT_OPTS, '-h', MPD_SERVER_IP, '-p', MPD_SERVER_PORT, 'volume', '+', VOLUME_STEP])


if __name__ == '__main__':
    skill ()
