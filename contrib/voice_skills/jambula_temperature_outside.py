#!/usr/local/bin/python3
"""
Jambula Smart Home Speech-to-Text skill
---------------------------------------
Task: Read the current temperature outside
Phrase: WHAT IS THE TEMPERATURE OUTSIDE
Compatibility: System, Home-Assistant
"""

from jambula_common import *
import subprocess

__author__ = 'Joseph Zikusooka'
__copyright__ = 'Jambula Labs @copyright 2023-2024 All rights reserved'
__license__ = 'GPLv3'
__version__ = "0.1.0"


phrase = 'WHAT IS THE TEMPERATURE OUTSIDE'

def skill ():
    MQTT_MESSAGE = 'on'
    subprocess.run ([MQTT_PUBLISH_CMD, '-h', MQTT_BROKER_IP, '-p', MQTT_BROKER_PORT, '-t', MQTT_TOPIC_STT_READ_TEMPERATURE_OUTSIDE, '-m', MQTT_MESSAGE])


if __name__ == '__main__':
    skill ()
