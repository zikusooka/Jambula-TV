#!/usr/local/bin/python3
"""
Jambula Smart Home Speech-to-Text skill
---------------------------------------
Task: Prayer time
Phrase: PRAYER TIME
Compatibility: System, Home-Assistant
"""

from jambula_common import *
import subprocess

__author__ = 'Joseph Zikusooka'
__copyright__ = 'Jambula Labs @copyright 2023-2024 All rights reserved'
__license__ = 'GPLv3'
__version__ = "0.1.0"


phrase = 'PRAYER TIME'

def skill ():
    MQTT_MESSAGE = 'start'
    subprocess.run ([MQTT_PUBLISH_CMD, '-h', MQTT_BROKER_IP, '-p', MQTT_BROKER_PORT, '-t', MQTT_TOPIC_STT_PRAYER_TIME, '-m', MQTT_MESSAGE])


if __name__ == '__main__':
    skill ()
