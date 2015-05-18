import xbmc,xbmcgui
import subprocess
import fnmatch
import os




# FM radio Command
FMRADIO_CMD = '/usr/bin/jambulatv-fmradio'
# Radio Output file
for line in open(FMRADIO_CMD):
 if "FM_RADIO_OUTPUT=" in line:
  radio_saved_output = line.split('=')[1]

# Home
radio_url_home = 'http://192.168.0.251:8090' # Jambula Radio via V4L2
radio_station = '93.3'
# Away
radio_url_away = 'http://107.150.12.29:8002/' # Internet link



# Check system for existing V4l Radio device e.g. /dev/radio1
for file in os.listdir('/dev'):
    if fnmatch.fnmatch(file, 'radio*'):
 
	# Play only using saa713X V4L Based card (Home)
	# Start FM radio player
	#os.system("/usr/bin/jambulatv-fmradio play start %s", radio_station)
	subprocess.check_call(['/usr/bin/jambulatv-fmradio', 'stream', 'start', radio_station])
	# Play using XBMC
	xbmc.Player().play(item=radio_saved_output)

else:
 	# Play Internet based stream
	# Play via (Away)
	xbmc.Player().play(item=radio_url_away)



	
	# Stream & Play (Home)
	# Start FM radio stream
	#os.system("/usr/bin/jambulatv-fmradio stream start %s", radio_station)
	# Wait a bit
	#xbmc.sleep(7000)
	# Play using XBMC
	#xbmc.Player().play(item=radio_url_home)

