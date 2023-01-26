#!/usr/local/bin/python3
"""
Jambula Smart Home Speech-to-Text skill
---------------------------------------
Task: Download currently playing music song 
Phrase: DOWNLOAD THE CURRENT SONG
Compatibility: System, Home-Assistant
"""

from jambula_common import *
import subprocess

__author__ = 'Joseph Zikusooka'
__copyright__ = 'Jambula Labs @copyright 2023-2024 All rights reserved'
__license__ = 'GPLv3'
__version__ = "0.1.0"


phrase = 'DOWNLOAD THE CURRENT SONG'

def skill ():
    subprocess.run ([MUSIC_DOWNLOAD_TOOL, 'youtube', 'playing'])


if __name__ == '__main__':
    skill ()
