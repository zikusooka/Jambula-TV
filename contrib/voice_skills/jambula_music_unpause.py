#!/usr/local/bin/python3
"""
Jambula Smart Home Speech-to-Text skill
---------------------------------------
Task: Un-pause currently playing music song
Phrase: CONTINUE WITH SONG
Compatibility: System, Home-Assistant
"""

from jambula_common import *
import subprocess

__author__ = 'Joseph Zikusooka'
__copyright__ = 'Jambula Labs @copyright 2023-2024 All rights reserved'
__license__ = 'GPLv3'
__version__ = "0.1.0"


phrase = 'CONTINUE WITH SONG'

def skill ():
    subprocess.run ([MPD_CLIENT_CMD, MPD_CLIENT_OPTS, '-h', MPD_SERVER_IP, '-p', MPD_SERVER_PORT, 'pause'])


if __name__ == '__main__':
    skill ()
