#!/usr/local/bin/python3
"""
Jambula Smart Home Speech-to-Text skill
---------------------------------------
Task: Say the time now
Phrase: WHAT IS THE TIME
Compatibility: System, Home-Assistant
"""

from jambula_common import *
import subprocess

__author__ = 'Joseph Zikusooka'
__copyright__ = 'Jambula Labs @copyright 2023-2024 All rights reserved'
__license__ = 'GPLv3'
__version__ = "0.1.0"


phrase = 'WHAT IS THE TIME'

def skill ():
    subprocess.run ([DATE_TIME_TOOL, '--time', 'now', '--volume', SPEAKER_ALERTS_VOLUME_LEVEL])


if __name__ == '__main__':
    skill ()
