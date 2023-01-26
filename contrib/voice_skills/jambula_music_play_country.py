#!/usr/local/bin/python3
"""
Jambula Smart Home Speech-to-Text skill
---------------------------------------
Task: Start playing Country music
Phrase: PLAY COUNTRY MUSIC
Compatibility: System, Home-Assistant
"""

from jambula_common import *
import subprocess

__author__ = 'Joseph Zikusooka'
__copyright__ = 'Jambula Labs @copyright 2023-2024 All rights reserved'
__license__ = 'GPLv3'
__version__ = "0.1.0"


phrase = 'PLAY COUNTRY MUSIC'

def skill ():
    MQTT_MESSAGE = 'country'
    subprocess.run ([MQTT_PUBLISH_CMD, '-h', MQTT_BROKER_IP, '-p', MQTT_BROKER_PORT, '-t', MQTT_TOPIC_STT_PLAY_MUSIC_GENRE, '-m', MQTT_MESSAGE])


if __name__ == '__main__':
    skill ()
