#!/usr/bin/env python
# Things to run when Kodi's GUI display shows up
#
import subprocess
import fnmatch
import time
#
#
# Wait for OSD to be fully initialized, since we need to notify on display
time.sleep(30) 

# Reminders: Birthdays, Anniversaries, Holidays, etc
# subprocess.check_call(['/usr/bin/jambulatv-remind']) # Not needed:- see reminders.timer
