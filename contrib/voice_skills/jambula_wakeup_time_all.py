#!/usr/local/bin/python3
"""
Jambula Smart Home Speech-to-Text skill
---------------------------------------
Task: Activate wake-up time routines for everybody
Phrase: WAKE UP TIME FOR ALL
Compatibility: System, Home-Assistant
"""

from jambula_common import *
import subprocess

__author__ = 'Joseph Zikusooka'
__copyright__ = 'Jambula Labs @copyright 2023-2024 All rights reserved'
__license__ = 'GPLv3'
__version__ = "0.1.0"


phrase = 'WAKE UP TIME FOR ALL'

def skill ():
    MQTT_MESSAGE = 'off'
    subprocess.run ([MQTT_PUBLISH_CMD, '-h', MQTT_BROKER_IP, '-p', MQTT_BROKER_PORT, '-t', MQTT_TOPIC_STT_WAKEUP_TIME_ALL, '-m', MQTT_MESSAGE])


if __name__ == '__main__':
    skill ()
