#!/usr/local/bin/python3
"""
Jambula Smart Home Speech-to-Text skill
---------------------------------------
Task: Reset the volume levels of player & system
Phrase: RESET VOLUME
Compatibility: System, Home-Assistant
"""

from jambula_common import *
import subprocess

__author__ = 'Joseph Zikusooka'
__copyright__ = 'Jambula Labs @copyright 2023-2024 All rights reserved'
__license__ = 'GPLv3'
__version__ = "0.1.0"


phrase = 'RESET VOLUME'

def skill ():
    subprocess.run ([SPEAKER_VOLUME_TOOL, 'all', 'localhost', SYSTEM_PLAYER_VOLUME_LEVEL, '%'])


if __name__ == '__main__':
    skill ()
