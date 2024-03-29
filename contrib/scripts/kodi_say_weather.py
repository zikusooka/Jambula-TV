#!/usr/bin/env python
# Ask for Weather Forecast

__author__ = 'JambulaTV'

import subprocess
import sys

SPEECH_API = '1'

# Pause Player
subprocess.check_call(['/usr/bin/jambulatv-kodi-controller', 'video_play_pause', 'noreplay'])
# Say current time
subprocess.check_call(['/usr/bin/jambulatv-text2speech', SPEECH_API, 'weather'])
# Un Pause Player
subprocess.check_call(['/usr/bin/jambulatv-kodi-controller', 'video_play_pause'])
