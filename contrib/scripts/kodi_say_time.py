#!/usr/bin/env python
# Ask for current time

__author__ = 'JambulaTV'

import subprocess
import sys

SPEECH_API = '2'

# Pause Player
subprocess.check_call(['/usr/bin/jambulatv-kodi-controller', 'video_play_pause', 'noreplay'])
# Say current time
subprocess.check_call(['/usr/bin/jambulatv-text2speech', SPEECH_API, 'time'])
# Un Pause Player
subprocess.check_call(['/usr/bin/jambulatv-kodi-controller', 'video_play_pause'])
