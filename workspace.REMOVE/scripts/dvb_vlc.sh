#!/bin/sh
clear

FREQUENCY=474000000
#FREQUENCY=538000000


/usr/bin/vlc -I dummy -V xv -f --width 1024 --height 768 --key-quit=esc dvb-t2://12 :dvb-caching=1200 :dvb-frequency=$FREQUENCY :dvb-inversion=-1 :dvb-bandwidth=8 :dvb-a-fec=2/3 :dvb-transmission=8 :dvb-b-modulation=QPSK :dvb-guard=1/4 :dvb-hierarchy :program=$1 :dvb-plp-id=12

#cvlc -f -V xv dvb:// :dvb-caching=1200 :dvb-frequency=474000000 :dvb-inversion=-1 :dvb-bandwidth=8 :dvb-a-fec=2/3 :dvb-transmission=8 :dvb-b-modulation=QPSK :dvb-guard=1/4 :dvb-hierarchy :program=$1 

#cvlc -f -V xv dvb-t:// :dvb-frequency=474000000 :dvb-inversion=-1 :dvb-transmission=8 :dvb-bandwidth=8 :dvb-b-modulation=QPSK :program=12
