#!/usr/bin/env python3

import os
import time
import re
import sys
import logging
import errno
import paho.mqtt.client as mqtt


__author__ = 'Joseph Zikusooka'
__copyright__ = 'Copyright 2019-2020 All rights reserved'
__credits__ = ["Caleb Madrigal", "https://github.com/calebmadrigal/trackerjacker"]
__license__ = "GPL"
__version__ = "1.0.1"
__email__ = 'josephzik@gmail.com'
__status__ = "Production"


# -----------------------------------------------------------------------------
# Please change these variables:
MQTT_BROKER_IP = 'MY_MQTT_BROKER_IP'
MQTT_BROKER_PORT = MY_MQTT_BROKER_PORT
MQTT_TOPIC_PRESENCE_TRACKERJACKER = 'MY_MQTT_TOPIC_PRESENCE_TRACKERJACKER'
MQTT_PRESENCE_SIGHTED = 'Sighted'

PRESENCE_VIA_TRACKER_THRESHOLD_TIME = MY_PRESENCE_VIA_TRACKER_THRESHOLD_TIME
PRESENCE_VIA_TRACKER_DEVICES_SEEN_TEMP_DIR = 'MY_PRESENCE_VIA_TRACKER_DEVICES_SEEN_TEMP_DIR'
PRESENCE_VIA_TRACKER_DEVICES_SEEN_TEMP_FILE = PRESENCE_VIA_TRACKER_DEVICES_SEEN_TEMP_DIR + '/' + 'MY_PRESENCE_VIA_TRACKER_DEVICES_SEEN_LOG_NAME'
TRACKERJACKER_LOG_LEVEL = 'MY_TRACKERJACKER_LOG_LEVEL' # 'DEBUG' | 'INFO' | 'WARNING' | 'ERROR' | 'CRITICAL'
# -----------------------------------------------------------------------------


class Trackerjacker_Logging(object):
  
  def loglevel(self, i):
    method_name='loglevel_'+str(i)
    method=getattr(self, method_name, lambda :'Logging level is Invalid')
    return method()

  def loglevel_DEBUG(self):
    LOGGING_LEVEL = logging.basicConfig(level=logging.DEBUG)
    logging.debug (' WiFi Device was ' + MQTT_PRESENCE_SIGHTED)

  def loglevel_INFO(self):
    LOGGING_LEVEL = logging.basicConfig(level=logging.INFO)
    logging.info (' WiFi Device was ' + MQTT_PRESENCE_SIGHTED)

  def loglevel_WARNING(self):
    LOGGING_LEVEL = logging.basicConfig(level=logging.DEBUG)
    logging.warning (' WiFi Device was ' + MQTT_PRESENCE_SIGHTED)

  def loglevel_ERROR(self):
    LOGGING_LEVEL = logging.basicConfig(level=logging.DEBUG)
    logging.error (' WiFi Device was ' + MQTT_PRESENCE_SIGHTED)

  def loglevel_CRITICAL(self):
    LOGGING_LEVEL = logging.basicConfig(level=logging.DEBUG)
    logging.critical (' WiFi Device was ' + MQTT_PRESENCE_SIGHTED)


def trigger(dev_id=None, num_bytes=None, power=None, last_seen_time=0, last_presence_status='nearby', LOG_ENTRY='', **kwargs):

  # Create temp log directory if non-existent
  try:
      os.makedirs(PRESENCE_VIA_TRACKER_DEVICES_SEEN_TEMP_DIR)
  except OSError as e:
      if e.errno != errno.EEXIST:
          raise
  # Create temp log file if non-existent
  if not os.path.exists(PRESENCE_VIA_TRACKER_DEVICES_SEEN_TEMP_FILE):
    with open(PRESENCE_VIA_TRACKER_DEVICES_SEEN_TEMP_FILE, 'w+') as file:
      file.close()

  if num_bytes:
    for line in reversed(list(open(PRESENCE_VIA_TRACKER_DEVICES_SEEN_TEMP_FILE, 'r'))):
      if re.match(dev_id, line):
        last_seen_time = line.split(", ")[-4]
        last_presence_status = line.split(", ")[-1]
        break

    # Set our presence variables and times
    CURRENT_SEEN_TIME = round(float(time.time()))
    LAST_SEEN_TIME = round(float(last_seen_time))
    LAST_PRESENCE_STATUS = str.strip(last_presence_status)
    ELAPSED_SINCE_SEEN_TIME = CURRENT_SEEN_TIME - LAST_SEEN_TIME
    ELAPSED_TIME = round(ELAPSED_SINCE_SEEN_TIME)
    MONITORED_DEVICE = re.sub(':','-', dev_id)    
    WIFI_USER_LAST_SEEN_AS_PRESENT_TEMP_FILE = PRESENCE_VIA_TRACKER_DEVICES_SEEN_TEMP_DIR + '/' + MONITORED_DEVICE + '_is_nearby'
    LOG_ENTRY = '{}, {}, {}, {}, {}, nearby'.format(dev_id, power, CURRENT_SEEN_TIME, LAST_SEEN_TIME, ELAPSED_TIME)
    MQTT_PRESENCE_TOPIC = MQTT_TOPIC_PRESENCE_TRACKERJACKER + '/' + dev_id

    def on_message(client, userdata, message):
        time.sleep(1)
        print("received message =",str(message.payload.decode("utf-8")))
    # MQTT - Connect & Publish
    client= mqtt.Client("TrackerJacker") 
    client.on_message=on_message
    client.connect(MQTT_BROKER_IP, MQTT_BROKER_PORT, 60)
    client.loop_start() 
    #client.subscribe(MQTT_PRESENCE_TOPIC)
    time.sleep(2)
    client.publish(MQTT_PRESENCE_TOPIC, MQTT_PRESENCE_SIGHTED)
    time.sleep(2)
    client.disconnect() 

    # Add logged information if available
    if LOG_ENTRY is not '':

      # Add presence entry to temp log file
      with open (PRESENCE_VIA_TRACKER_DEVICES_SEEN_TEMP_FILE, 'a') as file:
        file.write(LOG_ENTRY + '\n')

      # Add 'user is nearby' temp file
      with open (WIFI_USER_LAST_SEEN_AS_PRESENT_TEMP_FILE, 'w') as temp_file:
        temp_file.close()

      # Logging - Broken - Fix!
      #jtvlogger=Trackerjacker_Logging()
      #jtvlogger.loglevel(TRACKERJACKER_LOG_LEVEL)
