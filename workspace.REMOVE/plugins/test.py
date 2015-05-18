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
radiostation = '93.3'
# Away
radio_url_away = 'http://107.150.12.29:8002/' # Internet link




#subprocess.check_call(['/usr/bin/jambulatv-fmradio', 'stream', 'start', radio_station])
subprocess.check_call(['echo', '/usr/bin/jambulatv-fmradio', 'stream', 'start', radiostation])
