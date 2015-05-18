#!/bin/sh
clear

mplayer -cache 1200 -vo xv -ao pulse -fs dvb://"$1" -demuxer lavf -lavfdopts probesize=128 -mc 10 -speed 0.97 -af scaletempo

#mplayer -cache 4096 -vo xv -ao pulse -fs dvb://"$1" -demuxer lavf 

#mplayer -cache 4096 -vo xv -ao pulse -fs dvb://"$1" -demuxer lavf -lavfdopts probesize=1300 -mc 10 -speed 0.97 -af scaletempo

#mplayer -cache 4096 -vo xv -ao pulse -fs dvb://"$1" -demuxer lavf -lavfdopts analyzeduration=10000000 -lavfdopts probesize=1300 -mc 10 -speed 0.97 -af scaletempo
