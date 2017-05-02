#!/usr/bin/env python
# Turn light On/Off i.e. toggle switch

__author__ = 'JambulaTV'

import subprocess
import sys



# Turn lamp On/Off i.e. Toggle
subprocess.call(['/usr/bin/jambulatv-lights', 'Living Room', 'toggle', 'demo'])
