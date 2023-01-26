#!/usr/local/bin/python3
''' 
Global variables for Speech to Text
'''

__author__ = 'Joseph Zikusooka'
__copyright__ = 'MY_COPYRIGHT_NOTICE'
__license__ = 'GPLv3'
__version__ = "0.1.0"


# Source global settings for JambulaTV
project_global_settings_file = 'MY_GLOBAL_SETTINGS_FILE'
with open (project_global_settings_file) as global_config:
    exec(global_config.read())

# MQTT topics for Speech-to-Text
MQTT_TOPIC_STT_BED_TIME_ALL = 'JambulaTV/house/speech2text/bed_time_all'
MQTT_TOPIC_STT_WAKEUP_TIME_ALL = 'JambulaTV/house/speech2text/wakeup_time_all'
MQTT_TOPIC_STT_PLAY_MUSIC_GENRE = 'JambulaTV/house/speech2text/play_music_genre'
MQTT_TOPIC_STT_READ_TEMPERATURE_OUTSIDE = 'JambulaTV/house/speech2text/read_temperature_outside'
MQTT_TOPIC_STT_TV_TIME = 'JambulaTV/house/speech2text/tv_time'
MQTT_TOPIC_STT_MOVIE_TIME = 'JambulaTV/house/speech2text/movie_time'
MQTT_TOPIC_STT_LUNCH_TIME = 'JambulaTV/house/speech2text/lunch_time'
MQTT_TOPIC_STT_DINNER_TIME = 'JambulaTV/house/speech2text/dinner_time'
MQTT_TOPIC_STT_PRAYER_TIME = 'JambulaTV/house/speech2text/prayer_time'
MQTT_TOPIC_STT_GARBAGE_COLLECTED = 'JambulaTV/house/speech2text/garbage_collected'
