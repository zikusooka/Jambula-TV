#!/usr/bin/python
# This script is called by the ZoneMinderAlarm daemon/script and notifies
# all XBMC installations to overlay pictures on the screen
# It requires the doorbell xbmc plugin
# http://homeawesomation.wordpress.com/2013/02/18/doorbell-ipcam-xbmc-update/
# Credit for send_json_command to u/sffjunkie
# http://forum.xbmc.org/showthread.php?tid=92196
#
# Modified for use with JambulaTV - Jambula Labs
# --

# Variables
KODI_GUI_SETTINGS = "/JambulaTV/.kodi/userdata/guisettings.xml"
TIME = 15000  # ms
ICON = '/usr/share/kodi/addons/Aeon-Nox/media/DefaultIconInfo.png'

# Import modules
import json
import httplib
import base64
import sys
import argparse
import os
import warnings
import xml.etree.ElementTree as ET

# Get Kodi web server variables
tree = ET.parse(KODI_GUI_SETTINGS)
root = tree.getroot()
for services in root.findall('services'):
   username = services.find('webserverusername').text
   password = services.find('webserverpassword').text
   xbmc_port = services.find('webserverport').text
   xbmc_host=['127.0.0.1']



# Main Script 
# -----------
args = ['CamID','CamName']
dbvar = {'CamID': 1,
    'CamName': 'Default'}
for item in sys.argv:
    arg = item.split('=')
    i = arg[0]
    if arg[0] in args:
        j = arg[1]
        dbvar.update({arg[0]:arg[1]})


def send_json_command(xbmc_host, xbmc_port, method, params=None, id=1, username=username, password=password):
    command = {'jsonrpc': '2.0', 'id': id, 'method': method}
    if params is not None: command['params'] = params
    payload = json.dumps(command, ensure_ascii=False, sort_keys=True)
    payload.encode('utf-8')
    headers = {'Content-Type': 'application/json'}
    if password != '':
        userpass = base64.encodestring('%s:%s' % (username, password))[:-1]
        headers['Authorization'] = 'Basic %s' % userpass
    conn = httplib.HTTPConnection(xbmc_host, xbmc_port)
    data = None
    try:
        conn.request('POST', '/jsonrpc', payload, headers)
        response = conn.getresponse()
        if response.status == 200: data = json.loads(response.read())['result']
        else: data = 'Response Error'
    except:
        data = 'Connection Error'
    conn.close()
    return data



#  Jambula Labs: De-activate screensaver
def xbmc_poke_screen(xbmc_host, xbmc_port=xbmc_port):
    for x in range(0, len(xbmc_host)):                                                  
	screenSaverStatus = send_json_command(xbmc_host[x], xbmc_port, 'XBMC.GetInfoBooleans', params={'booleans':['System.ScreenSaverActive']})
        if screenSaverStatus == {u'System.ScreenSaverActive': True}:
	  send_json_command(xbmc_host[x], xbmc_port, "Input.Select")

# Display Camera where motion was detected
def xbmc_doorbell(xbmc_host, xbmc_port=xbmc_port):
    for x in range(0, len(xbmc_host)):
        result = send_json_command(xbmc_host[x], xbmc_port, 'Addons.ExecuteAddon',{'addonid':'script.doorbell','params':{'CamID':str(dbvar['CamID']),'CamName':str(dbvar['CamName'])}})
 

# Jambula Labs: Poke screen if screensaver is active
xbmc_poke_screen(xbmc_host)

# Display Camera alarm
xbmc_doorbell(xbmc_host)
