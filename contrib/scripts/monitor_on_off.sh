#!/bin/sh
# Turn monitor on or off if off or on, respectively
# Queries whether the monitor is on according to DPMS. If true then turns the monitor off, # if false turns it on. The -display option on xset means the command will work from 
# sessions other than the console, such as ssh or a cron'd script. 
# Command should display any errors if there are any problems (eg no X available), 
# otherwise no output if successful.


xset -display :0 q | grep ' Monitor is On' > /dev/null && xset -display :0 dpms force off || xset -display :0 dpms force on
